FROM craftercms/base
#Also uber.calderon@rivetlogic.com
#Also luis.cerdas@rivetlogic.com
MAINTAINER carlos.ortiz@craftersoftware.com

USER crafter

ADD ./config/studio/server-config.properties $CATALINA_HOME/shared/classes/crafter/cstudio/extension/
ADD ./config/studio/services-context.xml $CATALINA_HOME/shared/classes/crafter/cstudio/extension/

ADD ./config/engine/server-config.properties $CATALINA_HOME/shared/classes/crafter/engine/extension/
ADD ./config/engine/rendering-context.xml $CATALINA_HOME/shared/classes/crafter/engine/extension/
ADD ./config/engine/services-context.xml $CATALINA_HOME/shared/classes/crafter/engine/extension/

ADD ./config/solr-crafter.xml $CATALINA_HOME/conf/Catalina/localhost/

WORKDIR ${TMP_PATH}
RUN unzip -q crafter-studio-publishing-receiver.zip -d $CRAFTER_DEPLOYER_HOME
RUN chmod +x $CRAFTER_DEPLOYER_HOME/*.sh

RUN mv crafter-studio.war $CATALINA_HOME/webapps/studio.war
RUN mv crafter-search-server.war $CATALINA_HOME/webapps/crafter-search.war
RUN mv crafter-engine.war $CATALINA_HOME/webapps/ROOT.war
RUN mv solr.war $CATALINA_HOME/webapps/solr-crafter.war
RUN mv commons-daemon.jar $CRAFTER_DEPLOYER_HOME/commons-daemon.jar
RUN mv search/crafter-search-provider/solr $CATALINA_HOME/solr-crafter

RUN rm $CRAFTER_DEPLOYER_HOME/conf/*
RUN mkdir -pv $CRAFTER_DEPLOYER_HOME/target/site/content/
ADD ./config/deployer/sample-target-context.xml $CRAFTER_DEPLOYER_HOME/conf
ADD ./config/deployer/preview-target-context.xml $CRAFTER_DEPLOYER_HOME/conf
#x
ADD ./config/deployerStart.sh $CRAFTER_DEPLOYER_HOME
ADD ./config/deployerStop.sh $CRAFTER_DEPLOYER_HOME
ADD ./config/runStudio.sh $CRAFTER_HOME/

VOLUME ${CRAFTER_HOME}/data
VOLUME ${CRAFTER_HOME}/deployer/conf
VOLUME ${CRAFTER_HOME}/deployer/target
USER root
ADD ./config/deployer-supervisor.conf /etc/supervisor/conf.d/
