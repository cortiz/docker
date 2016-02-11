FROM craftercms/dev-full
ENV BUILD_ON=201602101530crt
RUN apt-get update
RUN apt-get install -y --force-yes --no-install-recommends apache2
RUN echo >> /etc/apache2/apache2.conf
RUN a2enmod cgid headers proxy proxy_http proxy_ajp reqtimeout rewrite ssl  socache_shmcb expires
ADD https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb /opt/ext/mod-pagespeed-stable_current_amd64.deb
RUN dpkg -i /opt/ext/mod-pagespeed-stable_current_amd64.deb
RUN mkdir -p /opt/craftercms/www
RUN mkdir -p /etc/apache2/sslcerts/
RUN mkdir -p /opt/craftercms/logs/
RUN rm /etc/apache2/sites-enabled/000-default.conf
ADD ./config/common-settings /etc/apache2/
ADD ./config/authoringcrafter.conf /etc/apache2/sites-enabled/
ADD ./config/crafterCmsAuthoringSSl.crt /etc/apache2/sslcerts/
ADD ./config/crafterCmsAuthoringSSl.key /etc/apache2/sslcerts/
ADD ./config/deployer/sample-target-context.xml /opt/craftercms/deployer/conf
ADD ./config/deployer/preview-target-context.xml /opt/craftercms/deployer/conf
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
