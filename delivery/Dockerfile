FROM ubuntu:bionic
MAINTAINER Carlos Ortiz <carlos.ortiz@craftercms.org>
RUN apt-get update && apt-get upgrade -y && apt-get install -y wget openjdk-8-jdk-headless lsof openssh-client 
RUN groupadd -g 999 crafter && \
    useradd -r -u 999 -g crafter crafter
RUN mkdir -pv /opt/
RUN chown -Rv crafter /opt/
USER crafter
WORKDIR /opt/
RUN wget https://downloads.craftercms.org/3.0.13/crafter-cms-delivery.tar.gz.sha512 --progress=bar:force
RUN wget https://downloads.craftercms.org/3.0.13/crafter-cms-delivery.tar.gz --progress=bar:force
RUN sha512sum -c crafter-cms-delivery.tar.gz.sha512
RUN tar xvf crafter-cms-delivery.tar.gz
RUN perl -pi -e "s/$CRAFTER_HOME\/apache-tomcat\/bin\/catalina.sh start -secure/$CRAFTER_HOME\/apache-tomcat\/bin\/catalina.sh run -secure/g;" /opt/crafter/bin/crafter.sh
EXPOSE 9080
EXPOSE 9009
EXPOSE 8695
EXPOSE 9192
VOLUME /opt/crafter/data/
CMD ["/opt/crafter/bin/startup.sh"]
