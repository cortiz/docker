FROM craftercms/local
USER root
RUN apt-get update
RUN apt-get install -y --force-yes --no-install-recommends apache2 mysql-server-5.5
RUN a2enmod cgid headers proxy proxy_http proxy_ajp reqtimeout rewrite ssl  socache_shmcb expires
ADD https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb /opt/ext/mod-pagespeed-stable_current_amd64.deb
RUN dpkg -i /opt/ext/mod-pagespeed-stable_current_amd64.deb
RUN mkdir -p ${CRAFTER_HOME}/www
RUN mkdir -p /etc/apache2/sslcerts/
RUN mkdir -p ${CRAFTER_HOME}/logs/
RUN rm /etc/apache2/sites-enabled/000-default.conf
ADD ./config/common-settings /etc/apache2/
ADD ./config/authoringcrafter.conf /etc/apache2/sites-enabled/
ADD ./config/crafterCmsAuthoringSSl.crt /etc/apache2/sslcerts/
ADD ./config/crafterCmsAuthoringSSl.key /etc/apache2/sslcerts/

USER crafter
ADD ./config/deployer/sample-target-context.xml $CRAFTER_DEPLOYER_HOME/conf
ADD ./config/deployer/preview-target-context.xml $CRAFTER_DEPLOYER_HOME/conf
ADD ./config/craftercms_mysql.cnf /etc/mysql/conf.d/
ADD ./config/craftercms.sql $CRAFTER_HOME/
ADD ./config/studio/server-config.properties $CATALINA_HOME/shared/classes/crafter/cstudio/extension/
ADD http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.38/mysql-connector-java-5.1.38.jar $CATALINA_HOME/lib/mysql.jar
#Make sure that Config is pickup
USER root
RUN service mysql start &&\
    mysql < $CRAFTER_HOME/craftercms.sql &&\
    service mysql stop
RUN apachectl configtest

USER  crafter

EXPOSE 80
EXPOSE 443
VOLUME /etc/apache2/sslcerts/
VOLUME $CRAFTER_HOME/www/
VOLUME $CRAFTER_HOME/logs/

ADD ./config/dockerStartup.sh $CRAFTER_HOME
ADD ./config/setenv.sh  $CATALINA_HOME/bin/
USER root
RUN chmod +x $CATALINA_HOME/bin/setenv.sh
RUN chmod +x dockerStartup.sh
RUN chown crafter $CATALINA_HOME/bin/setenv.sh
RUN chown  crafter $CATALINA_HOME/shared/classes/crafter/cstudio/extension/server-config.properties
RUN chown crafter dockerStartup.sh
CMD ["./dockerStartup.sh"]
