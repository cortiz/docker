FROM craftercms/dev-full:snapshot
RUN apt-get update
RUN apt-get install -y --force-yes --no-install-recommends apache2
RUN a2enmod cgid headers proxy proxy_http proxy_ajp reqtimeout rewrite ssl  socache_shmcb expires
ADD https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb /opt/ext/mod-pagespeed-stable_current_amd64.deb
RUN dpkg -i /opt/ext/mod-pagespeed-stable_current_amd64.deb
RUN rm $CATALINA_HOME/webapps/studio.war
RUN rm -rf $CATALINA_HOME/shared/classes/crafter/cstudio
RUN rm $CATALINA_HOME/shared/classes/crafter/engine/extension/*
#Engine Config
ADD ./config/engine/server-config.properties $CATALINA_HOME/shared/classes/crafter/engine/extension/
ADD ./config/engine/rendering-context.xml $CATALINA_HOME/shared/classes/crafter/engine/extension/
ADD ./config/engine/services-context.xml $CATALINA_HOME/shared/classes/crafter/engine/extension/
#Config deployer
ADD ./config/deployer/sample-target-context.xml /opt/craftercms/deployer/conf
ADD ./config/deployer/preview-target-context.xml /opt/craftercms/deployer/conf
#Apache config
RUN a2enmod expires
RUN mkdir -p /opt/craftercms/www
RUN mkdir -p /etc/apache2/sslcerts/
RUN mkdir -p /opt/craftercms/logs/
RUN rm /etc/apache2/sites-enabled/000-default.conf
ADD ./config/common-settings /etc/apache2/
ADD ./config/common-settings /etc/apache2/
ADD ./config/common-security /etc/apache2/
ADD ./config/common-mounts /etc/apache2/
ADD ./config/crafterCmsDeliverySSl.crt /etc/apache2/sslcerts/
ADD ./config/crafterCmsDeliverySSl.key /etc/apache2/sslcerts/
ADD ./config/deliveryCrafter.conf /etc/apache2/sites-enabled/
RUN apachectl configtest
EXPOSE 80
EXPOSE 443
VOLUME /etc/apache2/sslcerts/
VOLUME /opt/craftercms/www/
VOLUME /opt/craftercms/logs/
ADD ./config/dockerStartup.sh /opt/craftercms
ADD ./config/setenv.sh  $CATALINA_HOME/bin/
RUN chmod +x $CATALINA_HOME/bin/setenv.sh
RUN chmod +x dockerStartup.sh
CMD ["./dockerStartup.sh"]
