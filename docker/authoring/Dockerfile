FROM craftercms/base
#Also uber.calderon@rivetlogic.com
#Also luis.cerdas@rivetlogic.com
MAINTAINER carlos.ortiz@craftersoftware.com

USER crafter

### Crafter Configs
ADD ./config/studio/services-context.xml $CATALINA_HOME/shared/classes/crafter/cstudio/extension/
ADD ./config/engine/server-config.properties $CATALINA_HOME/shared/classes/crafter/engine/extension/
ADD ./config/engine/rendering-context.xml $CATALINA_HOME/shared/classes/crafter/engine/extension/
ADD ./config/engine/services-context.xml $CATALINA_HOME/shared/classes/crafter/engine/extension/
ADD ./config/solr-crafter.xml $CATALINA_HOME/conf/Catalina/localhost/
ADD ./config/studio/server-config.properties $CATALINA_HOME/shared/classes/crafter/cstudio/extension/
ADD http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.38/mysql-connector-java-5.1.38.jar $CATALINA_HOME/lib/mysql-connector-java-5.1.38.jar
ADD ./config/setenv.sh  $CATALINA_HOME/bin/

### Install bins
WORKDIR ${TMP_PATH}
RUN unzip -q crafter-studio-publishing-receiver.zip -d $CRAFTER_DEPLOYER_HOME


RUN mv crafter-studio.war $CATALINA_HOME/webapps/studio.war
RUN mv crafter-search-server.war $CATALINA_HOME/webapps/crafter-search.war
RUN mv crafter-engine.war $CATALINA_HOME/webapps/ROOT.war
RUN mv solr.war $CATALINA_HOME/webapps/solr-crafter.war
RUN mv commons-daemon.jar $CRAFTER_DEPLOYER_HOME/commons-daemon.jar
RUN mv search/crafter-search-provider/solr $CATALINA_HOME/solr-crafter

### Add updated deployer Config (for docker)
RUN rm $CRAFTER_DEPLOYER_HOME/conf/*
RUN mkdir -pv $CRAFTER_DEPLOYER_HOME/target/site/content/

ADD ./config/deployer/sample-target-context.xml $CRAFTER_DEPLOYER_HOME/conf
ADD ./config/deployer/preview-target-context.xml $CRAFTER_DEPLOYER_HOME/conf
ADD ./config/deployerStart.sh $CRAFTER_DEPLOYER_HOME
ADD ./config/deployerStop.sh $CRAFTER_DEPLOYER_HOME

### APACHE & MYSQL
USER root
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y --force-yes --no-install-recommends apache2 mysql-server-5.7
RUN a2enmod cgid headers proxy proxy_http proxy_ajp reqtimeout rewrite ssl  socache_shmcb expires
ADD https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb /opt/ext/mod-pagespeed-stable_current_amd64.deb
RUN dpkg -i /opt/ext/mod-pagespeed-stable_current_amd64.deb
### Config Apache
RUN rm /etc/apache2/sites-enabled/000-default.conf
ADD ./config/common-settings /etc/apache2/
ADD ./config/authoringcrafter.conf /etc/apache2/sites-enabled/

#### Config mysql
ADD ./config/craftercms_mysql.cnf /etc/mysql/conf.d/
ADD ./config/craftercms.sql $CRAFTER_HOME/
ADD ./config/initDb.sh $CRAFTER_HOME/
RUN rm -rf /var/lib/mysql/*
### Final General docker config
WORKDIR $CRAFTER_HOME

USER root
ADD ./config/apache-supervisor.conf /etc/supervisor/conf.d/
ADD ./config/mysql-supervisor.conf /etc/supervisor/conf.d/
ADD ./config/deployer-supervisor.conf /etc/supervisor/conf.d/
RUN chown crafter.crafter -R $CRAFTER_HOME
RUN chmod +x $CRAFTER_DEPLOYER_HOME/*.sh
RUN chmod +x $CRAFTER_HOME/initDb.sh
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

### 8080,8009 Already exported
EXPOSE 80
EXPOSE 443
CMD ["./initDb.sh"]
