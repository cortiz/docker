#!/bin/bash
/usr/bin/jsvc -home $JAVA_HOME -server -outfile $DEPLOYER_HOME/std.out -errfile err.out  -cp $DEPLOYER_HOME/conf:/$DEPLOYER_HOME -cwd $DEPLOYER_HOME -pidfile $DEPLOYER_HOME/deployer.pid -Djava.ext.dirs=$DEPLOYER_HOME org.craftercms.cstudio.publishing.PublishingReceiverMainDeamon
