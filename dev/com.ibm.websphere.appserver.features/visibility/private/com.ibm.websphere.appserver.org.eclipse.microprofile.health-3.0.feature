-include= ~${workspace}/cnf/resources/bnd/feature.props
symbolicName=com.ibm.websphere.appserver.org.eclipse.microprofile.health-3.0
singleton=true
-features=io.openliberty.mpCompatible-4.0
-bundles=io.openliberty.org.eclipse.microprofile.health.3.0; location:="dev/api/stable/,lib/"; mavenCoordinates="org.eclipse.microprofile.health:microprofile-health-api:3.0"
kind=beta
edition=core
WLP-Activation-Type: parallel
