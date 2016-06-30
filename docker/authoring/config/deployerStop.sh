#!/bin/bash
/usr/bin/jsvc -home $JAVA_HOME -server  -cp $CRAFTER_DEPLOYER_HOME/conf:/$CRAFTER_DEPLOYER_HOME -cwd $CRAFTER_DEPLOYER_HOME -stop -pidfile $CRAFTER_DEPLOYER_HOME/deployer.pid -Djava.ext.dirs=$CRAFTER_DEPLOYER_HOME org.craftercms.cstudio.publishing.PublishingReceiverMainDeamon
