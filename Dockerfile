FROM srvz/jenkins-master:python3.5.2

ARG MAVEN_VERSION=3.3.9

USER root

RUN cd /tmp \
	&& curl -v -O  http://www-us.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
	&& tar -zxf apache-maven-$MAVEN_VERSION-bin.tar.gz \
	&& mv apache-maven-$MAVEN_VERSION /usr/share/maven \
	&& ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
	&& ln -s /usr/share/maven/bin/mvnDebug /usr/bin/mvnDebug

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN npm version \
	&& npm config set cache /var/jenkins_home/.npmcache --global

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
	--recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
	&& echo "deb https://apt.dockerproject.org/repo debian-jessie main" >> \
	/etc/apt/sources.list.d/docker.list \
	&& apt-get update \
	&& apt-cache policy docker-engine \
	&& apt-get install -y docker-engine \
	&& rm -rf /var/lib/apt/lists/*

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
RUN gpasswd -a jenkins docker

WORKDIR /var/jenkins_home

USER jenkins

ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_SLAVE_AGENT_PORT 50000

EXPOSE 8080
EXPOSE 50000

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

VOLUME ["/var/jenkins_home"]
ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
