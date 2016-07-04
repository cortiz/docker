FROM craftercms/base:snapshot
MAINTAINER Carlos Ortiz <carlos.ortiz@craftersoftware.com> Uber Calderon <uber.calderon@rivetlogic.com> Luis Cerdas <luis.cerdas@rivetlogic.com>
USER crafter

### Crafter Configs
ADD ./config/engine/server-config.properties $CATALINA_HOME/shared/classes/crafter/engine/extension/
ADD ./config/engine/rendering-context.xml $CATALINA_HOME/shared/classes/crafter/engine/extension/
ADD ./config/engine/services-context.xml $CATALINA_HOME/shared/classes/crafter/engine/extension/
ADD ./config/solr-crafter.xml $CATALINA_HOME/conf/Catalina/localhost/
ADD ./config/setenv.sh  $CATALINA_HOME/bin/

### Install bins
WORKDIR ${TMP_PATH}
RUN unzip -q crafter-studio-publishing-receiver.zip -d $CRAFTER_DEPLOYER_HOME

RUN mv crafter-search-server.war $CATALINA_HOME/webapps/crafter-search.war
RUN mv crafter-engine.war $CATALINA_HOME/webapps/ROOT.war
RUN mv solr.war $CATALINA_HOME/webapps/solr-crafter.war
RUN mv commons-daemon.jar $CRAFTER_DEPLOYER_HOME/commons-daemon.jar
RUN mv search/crafter-search-provider/solr $CATALINA_HOME/solr-crafter

### Add updated deployer Config (for docker)
RUN rm $CRAFTER_DEPLOYER_HOME/conf/*
RUN mkdir -pv $CRAFTER_DEPLOYER_HOME/target/site/content/
ADD ./config/deployer/site-target-context.xml $TMP_PATH

ADD ./config/deployerStart.sh $CRAFTER_DEPLOYER_HOME
ADD ./config/deployerStop.sh $CRAFTER_DEPLOYER_HOME

### APACHE
USER root
RUN apt-get update
RUN apt-get install -y --force-yes --no-install-recommends apache2
RUN a2enmod cgid headers proxy proxy_http proxy_ajp reqtimeout rewrite ssl  socache_shmcb expires
ADD https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb /opt/ext/mod-pagespeed-stable_current_amd64.deb
RUN dpkg -i /opt/ext/mod-pagespeed-stable_current_amd64.deb
### Config Apache
RUN rm /etc/apache2/sites-enabled/000-default.conf
ADD ./config/common-settings /etc/apache2/
ADD ./config/deliverycrafter.conf /etc/apache2/sites-enabled/

WORKDIR $CRAFTER_HOME

ADD ./config/apache-supervisor.conf /etc/supervisor/conf.d/
ADD ./config/deployer-supervisor.conf /etc/supervisor/conf.d/
RUN chown crafter.crafter -R $CRAFTER_HOME
RUN chmod +x $CRAFTER_DEPLOYER_HOME/*.sh
RUN mkdir -p $CRAFTER_HOME/www/
RUN mkdir -p /etc/apache2/sites-enabled-ext
RUN echo "IncludeOptional sites-enabled-ext/*.conf" >> /etc/apache2/apache2.conf
RUN apachectl configtest

VOLUME ${CRAFTER_HOME}/data
VOLUME ${CRAFTER_HOME}/deployer/conf
VOLUME ${CRAFTER_HOME}/deployer/target
VOLUME $CRAFTER_HOME/www/
VOLUME /var/lib/mysql/
VOLUME /etc/apache2/sites-enabled-ext
# clean packages
RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
ADD ./config/init.sh $CRAFTER_HOME
RUN chmod +x $CRAFTER_HOME/init.sh

### 8080,8009 Already exported
EXPOSE 80
EXPOSE 443
CMD ["./init.sh"]
