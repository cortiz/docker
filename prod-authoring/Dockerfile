FROM craftercms/dev-full:unstable
ENV BUILD_ON=201602091545crt
RUN apt-get update
RUN apt-get install -y --force-yes --no-install-recommends apache2
RUN echo ServerName CrafterCms-Authoring >> /etc/apache2/apache2.conf
RUN a2enmod cgid headers proxy proxy_http proxy_ajp reqtimeout rewrite ssl  socache_shmcb
ADD https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb /opt/ext/mod-pagespeed-stable_current_amd64.deb
RUN dpkg -i /opt/ext/mod-pagespeed-stable_current_amd64.deb
RUN mkdir -p /opt/craftercms/www
RUN mkdir -p /etc/apache2/sslcerts/
RUN mkdir -p /opt/craftercms/logs/
RUN rm /etc/apache2/sites-enabled/000-default.conf
ADD ./config/common-settings /etc/apache2/
ADD ./config/authoringcraftercloudio.conf /etc/apache2/sites-enabled/
ADD ./config/crafterCmsAuthoringSSl.crt /etc/apache2/sslcerts/
ADD ./config/crafterCmsAuthoringSSl.key /etc/apache2/sslcerts/
RUN apachectl configtest
EXPOSE 80
EXPOSE 443
VOLUME /etc/apache2/sslcerts/
VOLUME /opt/craftercms/www/
VOLUME /opt/craftercms/logs/
ADD ./config/authoringDockerStartup.sh /opt/craftercms
RUN chmod +x authoringDockerStartup.sh
CMD ["./authoringDockerStartup.sh"]
