#!/bin/bash
/usr/bin/jsvc -home $JAVA_HOME -server  -cp $DEPLOYER_HOME/conf:/$DEPLOYER_HOME -cwd $DEPLOYER_HOME -stop -pidfile $DEPLOYER_HOME/deployer.pid -Djava.ext.dirs=$DEPLOYER_HOME org.craftercms.cstudio.publishing.PublishingReceiverMainDeamon
