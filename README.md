JBEAP-12374
====

A simple script to help reproduce the discrepencies of files permissions between ZIP files produced for Wildfly and EAP. Simply download a EAP from RHN and run the script on it:

    $ ./show-privileges.sh jboss-eap-7.1-from-rhn.zip
    Extracting jboss-eap-7.1-from-rhn.zip archive into /tmp/tmp.SjlRQHG1L3...Done.
    -rw-rw-r--. 1 rpelisse rpelisse 401354  3 nov.  16:05 /tmp/tmp.SjlRQHG1L3/jboss-eap-7.1/jboss-modules.jar
    drwxrwxr-x. 5 rpelisse rpelisse 100  3 nov.  16:05 /tmp/tmp.SjlRQHG1L3/jboss-eap-7.1/domain/
    Looking for jars with priviliges different from -rw-rw-r-- ... Done.

This rather brief output indicates that the zipfile provided suffers from the files permissions discrepencies discussed on [JBEAP-12374](https://issues.jboss.org/browse/JBEAP-12374). If you then uses a ZIP file downloaded from the Wildfly.org website, like [Wildfly 12](http://download.jboss.org/wildfly/11.0.0.Final/wildfly-11.0.0.Final.zip) or even as old as [Wildlfy 10.0.0.Final](http://download.jboss.org/wildfly/10.0.0.Final/wildfly-10.0.0.Final.zip), you'll get a for more lenghty output from the scripts:

    $ ./show-privileges.sh wildfly-10.0.0.Final.zip
    Extracting wildfly-10.0.0.Final.zip archive into /tmp/tmp.HVP3A2rEai...Done.
    -rw-r--r--. 1 rpelisse rpelisse 364930 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/jboss-modules.jar
    drwxr-xr-x. 5 rpelisse rpelisse 100 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/domain/
    Looking for jars with priviliges different from -rw-rw-r-- ... -rw-r--r--. 1 rpelisse rpelisse 269295 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/modules/system/layers/base/org/yaml/snakeyaml/main/snakeyaml-1.15.jar
    -rw-r--r--. 1 rpelisse rpelisse 191730 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/modules/system/layers/base/org/wildfly/security/elytron/main/wildfly-elytron-1.0.2.Final.jar
    -rw-r--r--. 1 rpelisse rpelisse 39920 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/modules/system/layers/base/org/wildfly/mod_cluster/undertow/main/wildfly-mod_cluster-undertow-10.0.0.Final.jar
    -rw-r--r--. 1 rpelisse rpelisse 9495 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/modules/system/layers/base/org/wildfly/jberet/main/wildfly-jberet-10.0.0.Final.jar
    -rw-r--r--. 1 rpelisse rpelisse 319189 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/modules/system/layers/base/org/wildfly/iiop-openjdk/main/wildfly-iiop-openjdk-10.0.0.Final.jar
    -rw-r--r--. 1 rpelisse rpelisse 678621 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/modules/system/layers/base/org/wildfly/extension/undertow/main/wildfly-undertow-10.0.0.Final.jar
    -rw-r--r--. 1 rpelisse rpelisse 32648 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/modules/system/layers/base/org/wildfly/extension/security/manager/main/wildfly-security-manager-10.0.0.Final.jar
    -rw-r--r--. 1 rpelisse rpelisse 37065 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/modules/system/layers/base/org/wildfly/extension/rts/main/wildfly-rts-10.0.0.Final.jar
    -rw-r--r--. 1 rpelisse rpelisse 37872 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/modules/system/layers/base/org/wildfly/extension/request-controller/main/wildfly-request-controller-2.0.10.Final.jar
    -rw-r--r--. 1 rpelisse rpelisse 301185 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/modules/system/layers/base/org/wildfly/extension/picketlink/main/wildfly-picketlink-10.0.0.Final.jar
    -rw-r--r--. 1 rpelisse rpelisse 147888 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/modules/system/layers/base/org/wildfly/extension/mod_cluster/main/wildfly-mod_cluster-extension-10.0.0.Final.jar
    -rw-r--r--. 1 rpelisse rpelisse 592625 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/modules/system/layers/base/org/wildfly/extension/messaging-activemq/main/wildfly-messaging-activemq-10.0.0.Final.jar
    -rw-r--r--. 1 rpelisse rpelisse 46420 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/modules/system/layers/base/org/wildfly/extension/messaging-activemq/main/artemis-wildfly-integration-1.0.2.jar
    -rw-r--r--. 1 rpelisse rpelisse 46929 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/modules/system/layers/base/org/wildfly/extension/io/main/wildfly-io-2.0.10.Final.jar
    -rw-r--r--. 1 rpelisse rpelisse 62795 29 janv.  2016 /tmp/tmp.HVP3A2rEai/wildfly-10.0.0.Final/modules/system/layers/base/org/wildfly/extension/clustering/singleton/main/wildfly-clustering-singleton-extension-10.0.0.Final.jar
    ....
