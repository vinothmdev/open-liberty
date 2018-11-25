/*******************************************************************************
 * Copyright (c) 2018 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     IBM Corporation - initial API and implementation
 *******************************************************************************/
package jaxrs21.fat.interceptor;

import java.util.Set;

import javax.enterprise.context.RequestScoped;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

@Path("/requestScoped")
@RequestScoped
@InterceptableOne
@LifecycleInterceptableTwo
public class ResourceRequestScoped {

    @GET
    @Path("/postConstruct")
    public String getPostConstructInterceptors() {
        return whichLifecycleInterceptorsWereInvoked();
    }

    @GET
    @Path("/justOne")
    public String justOne() {
        return whichBusinessInterceptorsWereInvoked();
    }

    @GET
    @Path("/oneAndThree")
    @InterceptableThree
    public String oneAndThree() {
        return whichBusinessInterceptorsWereInvoked();
    }

    @GET
    @InterceptableTwo
    @InterceptableThree
    @Path("/all")
    public String oneTwoAndThree() {
        return whichBusinessInterceptorsWereInvoked();
    }

    private static String whichBusinessInterceptorsWereInvoked() {
        Set<String> interceptors = BagOfInterceptors.businessInterceptors.get();
        if (interceptors == null) {
            return "NONE";
        }
        String result = String.join(" ", interceptors);
        interceptors.clear();
        return result;
    }

    private static String whichLifecycleInterceptorsWereInvoked() {
        Set<String> interceptors = BagOfInterceptors.lifecycleInterceptors.get();
        if (interceptors == null) {
            return "NONE";
        }
        String result = String.join(" ", interceptors);
        interceptors.clear();
        return result;
    }
}
