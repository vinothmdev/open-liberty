/*******************************************************************************
 * Copyright (c) 2016, 2019 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     IBM Corporation - initial API and implementation
 *******************************************************************************/
package com.ibm.ws.collector;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.TimeUnit;

import com.ibm.websphere.ras.Tr;
import com.ibm.websphere.ras.TraceComponent;
import com.ibm.websphere.ras.annotation.Trivial;
import com.ibm.websphere.ssl.SSLException;
import com.ibm.ws.ffdc.annotation.FFDCIgnore;
import com.ibm.ws.logging.synch.ThreadLocalHandler;
import com.ibm.wsspi.kernel.service.utils.AtomicServiceReference;
import com.ibm.wsspi.ssl.SSLSupport;

/**
 * Task manager is responsible for sending events generated by collector tasks
 * to the relevant end point.
 *
 * It holds a reference to a pool of connections to the end point and maintains a queue of event lists
 * which it processes. Task manager is designed to not lose events, when a failure occurs while sending events
 * it will keep re-trying till it succeeds.
 */
public abstract class TaskManager implements Target, Runnable {

    private static final TraceComponent tc = Tr.register(TaskManager.class);

    private final AtomicServiceReference<SSLSupport> sslSupportServiceRef;
    private final AtomicServiceReference<ExecutorService> executorServiceRef;

    /** Queue that holds the list of events that need to be processed */
    private final LinkedBlockingDeque<List<Object>> newLists;

    private volatile ClientPool clientPool;
    private final int clientPoolSize;

    /** Flags to control configuration update or shutdown. */
    private volatile boolean shutDown;
    private volatile boolean updateConfig;

    private volatile String hostName;
    private volatile int port;
    private volatile String sslConfig;

    /** Config keys */
    private static final String HOST_NAME_KEY = "hostName";
    private static final String PORT_KEY = "port";
    private static final String SSL_REF_KEY = "sslRef";

    public TaskManager(AtomicServiceReference<SSLSupport> sslSupportServiceRef, AtomicServiceReference<ExecutorService> executorServiceRef, int poolSize) {
        this.clientPoolSize = poolSize;
        this.executorServiceRef = executorServiceRef;
        this.sslSupportServiceRef = sslSupportServiceRef;
        //Allocate additional capacity to hold lists that have to be re-tried.
        newLists = new LinkedBlockingDeque<List<Object>>(2 * clientPoolSize + 1);
        shutDown = updateConfig = false;
    }

    public synchronized void addNewList(List<Object> formattedEvents) {
        while (!appendList(formattedEvents))
            try {
                wait();
            } catch (InterruptedException e) {
                //Keep re-trying till we are able to add the element
            }
    }

    public synchronized void allowNewLists() {
        //The queue size has fallen below the pool size
        //so notify any thread that is waiting to add new list to the queue
        if (newLists.size() < clientPoolSize) {
            notifyAll();
        }
    }

    /* This method is not thread safe, gets called from the thread safe method addNewList(..) */
    private boolean appendList(List<Object> formattedEvents) {
        if (newLists.size() >= clientPoolSize)
            return false;
        boolean done = false;
        while (!done) {
            try {
                newLists.putLast(formattedEvents);
                done = true;
            } catch (InterruptedException e) {
                //Interrupted try again
            }
        }
        return true;
    }

    public void addRetryList(List<Object> retryEvents) {
        boolean done = false;
        while (!done) {
            try {
                newLists.putFirst(retryEvents);
                done = true;
            } catch (InterruptedException e) {
                //Interrupted try again
            }
        }
    }

    public List<Object> removeList() {
        try {
            List<Object> newList = newLists.pollFirst(500, TimeUnit.MILLISECONDS);
            return newList;
        } catch (InterruptedException e) {
            return null;
        }
    }

    public void clearList() {
        newLists.clear();
    }

    @Override
    public void sendEvents(List<Object> formattedEvents) {
        //Called by events buffer to add formatted events
        if (!shutDown) {
            addNewList(formattedEvents);
        }
    }

    public void setConfigInfo(Map<String, Object> config) {
        this.hostName = (String) config.get(HOST_NAME_KEY);
        this.port = (Integer) config.get(PORT_KEY);
        this.sslConfig = (String) config.get(SSL_REF_KEY);
    }

    public void updateConfig() {
        updateConfig = true;
    }

    @Override
    public void close() {
        shutDown = true;
    }

    @Override
    public void run() {
        //Set the thread local to indicate that any trace or logging
        //event should not be routed back to the handler
        ThreadLocalHandler.set(Boolean.TRUE);
        try {
            while (true) {
                try {
                    if (shutDown) {
                        //Clear the new lists queue and wake up EventsBuffer/TaskImpl threads thats are waiting
                        //on it.
                        clearList();
                        allowNewLists();
                        //Wait for the connections to come back to the pool
                        //and then break out of the loop.
                        if (clientPool != null)
                            clientPool.close();
                        break;
                    }
                    if (updateConfig) {
                        //The config got updated, existing connections should be closed.
                        //New connections will get created if we are able to create an SSL context
                        //using the new config.
                        if (clientPool != null)
                            clientPool.close();

                        try {
                            clientPool = null;
                            clientPool = createClientPool(sslConfig, sslSupportServiceRef.getService(), clientPoolSize);
                        } catch (SSLException e) {
                            if (TraceComponent.isAnyTracingEnabled() && tc.isEventEnabled())
                                Tr.event(tc, "SSLException creating client pool {0}", e);
                        }
                        updateConfig = false;
                    }
                    if (clientPool != null) {
                        //Pull the list from the from the head of the queue
                        List<Object> events = removeList();
                        if (events != null) {
                            //If the queue size has fallen below the threshold wake up threads
                            //to add new lists to the queue.
                            allowNewLists();
                            //See if you can get a connection from the pool
                            Client client = clientPool.checkoutClient();
                            if (client != null) {
                                SendEventsTask task = new SendEventsTask(this, events, client, clientPool, hostName, port);
                                ExecutorService execSrvc = executorServiceRef.getService();
                                //During shutdown executor service ref can return null
                                if (execSrvc != null)
                                    task.start(execSrvc);
                            } else {
                                //Re-queue the list we will try again when the connection is available.
                                addRetryList(events);
                            }
                        }
                    }
                } catch (Exception e) {
                    // FFDC and continue the loop
                }
            }
        } finally {
            ThreadLocalHandler.remove();
        }
    }

    public abstract ClientPool createClientPool(String sslConfig, SSLSupport sslSupport, int numClients) throws SSLException;

    static class SendEventsTask implements Runnable {

        private final TaskManager taskMgr;
        private final List<Object> events;
        private final Client client;
        private final ClientPool clientPool;
        private final String hostName;
        private final int port;

        public SendEventsTask(TaskManager taskMgr, List<Object> events,
                              Client client, ClientPool clientPool, String hostName, int port) {
            this.taskMgr = taskMgr;
            this.events = events;
            this.client = client;
            this.hostName = hostName;
            this.port = port;
            this.clientPool = clientPool;
        }

        public void start(ExecutorService executorService) {
            try {
                executorService.submit(this);
            } catch (Throwable t) {
                clientPool.checkinClient(client);
                taskMgr.addRetryList(events);
            }
        }

        @Override
        @Trivial
        @FFDCIgnore(value = { Exception.class })
        public void run() {
            //Set the thread local to indicate that any trace or logging
            //event should not be routed back to the handler
            ThreadLocalHandler.set(Boolean.TRUE);
            try {
                client.connect(hostName, port);
                client.sendData(events);
            } catch (Exception e) {
                if (TraceComponent.isAnyTracingEnabled() && tc.isEventEnabled()) {
                    Tr.event(tc, "Unable to send events to the target. Reason {0}", e);
                }
                //An exception occurred during connect or send operation
                try {
                    client.close();
                } catch (Exception ex) {
                    //Ignore this
                }
                //Put these events back on the queue as we failed to send them.
                taskMgr.addRetryList(events);
            } finally {
                clientPool.checkinClient(client);
                ThreadLocalHandler.remove();
            }
        }
    }
}
