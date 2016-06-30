#!/bin/bash
/usr/bin/jsvc -home $JAVA_HOME -server -outfile /dev/stdout -errfile /dev/stderr  -cp $CRAFTER_DEPLOYER_HOME/conf:/$CRAFTER_DEPLOYER_HOME -cwd $CRAFTER_DEPLOYER_HOME -pidfile $CRAFTER_DEPLOYER_HOME/deployer.pid -Djava.ext.dirs=$CRAFTER_DEPLOYER_HOME -nodetach org.craftercms.cstudio.publishing.PublishingReceiverMainDeamon
