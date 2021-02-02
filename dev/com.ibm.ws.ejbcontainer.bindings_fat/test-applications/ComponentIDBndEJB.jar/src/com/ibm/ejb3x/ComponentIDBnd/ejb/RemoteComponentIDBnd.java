/*******************************************************************************
 * Copyright (c) 2020 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     IBM Corporation - initial API and implementation
 *******************************************************************************/

package com.ibm.ejb3x.ComponentIDBnd.ejb;

/**
 * Remote interface for Enterprise Bean: ComponentIDBnd.
 */
public interface RemoteComponentIDBnd extends javax.ejb.EJBObject {

    public String foo() throws java.rmi.RemoteException;

}
