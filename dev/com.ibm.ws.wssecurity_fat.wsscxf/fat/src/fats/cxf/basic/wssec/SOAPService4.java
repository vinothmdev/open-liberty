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

package fats.cxf.basic.wssec;

import java.net.URL;

import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;
import javax.xml.ws.WebServiceFeature;

/**
 * This class was generated by Apache CXF 2.6.2
 * 2012-10-10T10:52:58.383-05:00
 * Generated source version: 2.6.2
 *
 */
@WebServiceClient(name = "SOAPService4",
                  wsdlLocation = "UsrTokenWebSvc.wsdl",
                  targetNamespace = "http://wssec.basic.cxf.fats")
public class SOAPService4 extends Service {

    public final static URL WSDL_LOCATION;

    public final static QName SERVICE = new QName("http://wssec.basic.cxf.fats", "SOAPService4");
    public final static QName SoapPort4 = new QName("http://wssec.basic.cxf.fats", "SoapPort4");
    static {
        URL url = SOAPService4.class.getResource("UsrTokenWebSvc.wsdl");
        if (url == null) {
            java.util.logging.Logger.getLogger(SOAPService4.class.getName()).log(java.util.logging.Level.INFO,
                                                                                 "Can not initialize the default wsdl from {0}", "UsrTokenWebSvc.wsdl");
        }
        WSDL_LOCATION = url;
    }

    public SOAPService4(URL wsdlLocation) {
        super(wsdlLocation, SERVICE);
    }

    public SOAPService4(URL wsdlLocation, QName serviceName) {
        super(wsdlLocation, serviceName);
    }

    public SOAPService4() {
        super(WSDL_LOCATION, SERVICE);
    }

    /**
     *
     * @return
     *         returns UsrToken
     */
    @WebEndpoint(name = "SoapPort4")
    public UsrToken getSoapPort4() {
        return super.getPort(SoapPort4, UsrToken.class);
    }

    /**
     *
     * @param features
     *                     A list of {@link javax.xml.ws.WebServiceFeature} to configure on the proxy. Supported features not in the <code>features</code> parameter will have their
     *                     default values.
     * @return
     *         returns UsrToken
     */
    @WebEndpoint(name = "SoapPort4")
    public UsrToken getSoapPort4(WebServiceFeature... features) {
        return super.getPort(SoapPort4, UsrToken.class, features);
    }

}
