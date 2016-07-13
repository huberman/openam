FROM tomcat:8-jre8

# copied from Dockerfile created by:
#MAINTAINER warren.strange@gmail.com
MAINTAINER hubert.matthews@transformuk.com

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME

EXPOSE 8080 4444 50389

ADD openam.war  /usr/local/tomcat/webapps/openam.war

ADD run-openam.sh /tmp/run-openam.sh

# Generate a default keystore for SSL.
# You can mount your own keystore on the ssl/ directory to override this
#RUN mkdir -p /usr/local/tomcat/ssl && \
#keytool -genkey -noprompt \
#-keyalg RSA \
#-alias tomcat \
#-dname "CN=forgerock.com, OU=ID, O=FORGEROCK, L=Calgary, S=AB, C=CA" \
#-keystore /usr/local/tomcat/ssl/keystore \
#-storepass password \
#-keypass password

ADD server.xml /usr/local/tomcat/conf/server.xml

RUN mkdir /root/openam

VOLUME /root/openam

CMD ["/tmp/run-openam.sh"]
