FROM craftercms/base
#Also uber.calderon@rivetlogic.com
#Also luis.cerdas@rivetlogic.com
MAINTAINER carlos.ortiz@craftersoftware.com


USER crafter

ADD ./config/engine/server-config.properties $CATALINA_HOME/shared/classes/crafter/engine/extension/
ADD ./config/engine/rendering-context.xml $CATALINA_HOME/shared/classes/crafter/engine/extension/
ADD ./config/engine/services-context.xml $CATALINA_HOME/shared/classes/crafter/engine/extension/

ADD ./config/solr-crafter.xml $CATALINA_HOME/conf/Catalina/localhost/

WORKDIR ${TMP_PATH}
RUN unzip -q crafter-studio-publishing-receiver.zip -d $CRAFTER_DEPLOYER_HOME
RUN chmod +x $CRAFTER_DEPLOYER_HOME/*.sh

RUN mv crafter-search-server.war $CATALINA_HOME/webapps/crafter-search.war
RUN mv crafter-engine.war $CATALINA_HOME/webapps/ROOT.war
RUN mv solr.war $CATALINA_HOME/webapps/solr-crafter.war
RUN mv commons-daemon.jar $CRAFTER_DEPLOYER_HOME/commons-daemon.jar
RUN mv search/crafter-search-provider/solr $CATALINA_HOME/solr-crafter

#RUN rm $CRAFTER_DEPLOYER_HOME/conf/*
RUN mkdir -p $CRAFTER_DEPLOYER_HOME/target/site/work-area/
COPY ./config/deployer/site-target-context.xml $CRAFTER_DEPLOYER_HOME/conf/

ADD ./config/deployerStart.sh $CRAFTER_DEPLOYER_HOME
ADD ./config/deployerStop.sh $CRAFTER_DEPLOYER_HOME


USER root
RUN apt-get update
ADD ./config/apache-supervisor.conf /etc/supervisor/conf.d/
RUN apt-get install -y --force-yes --no-install-recommends apache2
RUN a2enmod cgid headers proxy proxy_http proxy_ajp reqtimeout rewrite ssl  socache_shmcb expires
ADD https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb /opt/ext/mod-pagespeed-stable_current_amd64.deb
RUN dpkg -i /opt/ext/mod-pagespeed-stable_current_amd64.deb
RUN mkdir -p ${CRAFTER_HOME}/www
RUN mkdir -p /etc/apache2/sslcerts/
RUN rm /etc/apache2/sites-enabled/000-default.conf
ADD ./config/common-settings /etc/apache2/
ADD ./config/deliverycrafter.conf /etc/apache2/sites-enabled/
ADD ./config/crafterCmsAuthoringSSl.crt /etc/apache2/sslcerts/
ADD ./config/crafterCmsAuthoringSSl.key /etc/apache2/sslcerts/
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
VOLUME ${CRAFTER_HOME}/data
VOLUME ${CRAFTER_HOME}/deployer/conf
VOLUME ${CRAFTER_HOME}/deployer/target
RUN chown -R crafter $CRAFTER_HOME/
