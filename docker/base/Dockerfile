FROM ubuntu:xenial
#Also uber.calderon@rivetlogic.com
#Also luis.cerdas@rivetlogic.com
MAINTAINER carlos.ortiz@craftersoftware.com
RUN apt-get update && apt-get upgrade -y && apt-get install -y wget unzip git jsvc supervisor nano  2>/dev/null

ENV HOME=/home/crafter
ENV CRAFTER_HOME=$HOME/craftercms
ENV JDK_HOME=$HOME/jdk
ENV JAVA_HOME=$JDK_HOME/jre
ENV CATALINA_HOME=$CRAFTER_HOME/apache-tomcat
ENV PATH=$PATH:$JDK_HOME/bin:$CATALINA_HOME/bin
ENV TMP_PATH=$HOME/tmp

ENV CRAFTER_DEPLOYER_HOME=$CRAFTER_HOME/deployer
ENV CRAFTER_DATA_PATH=$CRAFTER_HOME/data
ENV CRAFTER_DB_PATH=$CRAFTER_DATA_PATH/db
ENV CRAFTER_REPO_PATH=$CRAFTER_DATA_PATH/repo

ENV MAVEN_REPO_URL=https://oss.sonatype.org
ENV MAVEN_REPO=snapshots
ENV CRAFTER_VERSION=LATEST
ENV SOLR_VERSION=4.10.4

RUN useradd -ms /bin/bash crafter
USER crafter

RUN mkdir -p "$CRAFTER_HOME"
RUN mkdir -p "$CRAFTER_DEPLOYER_HOME"
RUN mkdir -p "$TMP_PATH"

WORKDIR ${TMP_PATH}

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u92-b14/jdk-8u92-linux-x64.tar.gz --progress=bar:force
RUN wget http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.3/bin/apache-tomcat-8.5.3.tar.gz --progress=bar:force
RUN wget "$MAVEN_REPO_URL/service/local/artifact/maven/redirect?r=$MAVEN_REPO&g=org.craftercms&a=crafter-studio-publishing-receiver-zip&v=$CRAFTER_VERSION&p=zip" --content-disposition --progress=bar:force -O crafter-studio-publishing-receiver.zip
RUN wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=commons-daemon&a=commons-daemon&v=1.0.15" --content-disposition --progress=bar:force -O commons-daemon.jar
RUN wget "$MAVEN_REPO_URL/service/local/artifact/maven/redirect?r=$MAVEN_REPO&g=org.craftercms&a=crafter-studio-2&v=$CRAFTER_VERSION&p=war" --content-disposition --progress=bar:force -O crafter-studio.war
RUN wget "$MAVEN_REPO_URL/service/local/artifact/maven/redirect?r=$MAVEN_REPO&g=org.craftercms&a=crafter-search-server&v=$CRAFTER_VERSION&p=war" --content-disposition --progress=bar:force -O crafter-search-server.war
RUN wget "$MAVEN_REPO_URL/service/local/artifact/maven/redirect?r=$MAVEN_REPO&g=org.craftercms&a=crafter-engine&v=$CRAFTER_VERSION&p=war" --content-disposition --progress=bar:force -O crafter-engine.war
RUN wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=org.apache.solr&a=solr&v=$SOLR_VERSION&p=war" --content-disposition --progress=bar:force -O solr.war
RUN git clone https://github.com/craftercms/search.git

RUN tar xzvf $TMP_PATH/jdk-8u92-linux-x64.tar.gz && mv jdk1.8.0_92 $JDK_HOME
RUN tar xzvf $TMP_PATH/apache-tomcat-8.5.3.tar.gz && mv apache-tomcat-8.5.3 $CATALINA_HOME
RUN echo "shared.loader=\${catalina.base}/shared/classes,\${catalina.base}/shared/lib/*.jar" >> $CATALINA_HOME/conf/catalina.properties
RUN mkdir -p $CATALINA_HOME/shared/classes
RUN mkdir -p $CATALINA_HOME/shared/lib
RUN rm -rvf ${CATALINA_HOME}/webapps/*

ADD ./config/tomcat-supervisor.conf /etc/supervisor/conf.d/
ADD ./config/supervisord.conf /etc/supervisor/conf.d/
#Expose Tomcat ports
EXPOSE 8080
EXPOSE 8009
USER root
WORKDIR $CRAFTER_HOME
RUN chown -R crafter $CRAFTER_HOME/
CMD ["supervisord","-c","/etc/supervisor/supervisord.conf"]
