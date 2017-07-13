FROM centos:7

ARG JNLP_VERSION=3.7
ENV DOCKER_GID=992

COPY files/docker.repo /etc/yum.repos.d/docker.repo
RUN yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel git wget gettext rsync docker-engine && \
    yum clean all

RUN curl -L "https://github.com/docker/compose/releases/download/1.13.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${JNLP_VERSION}/remoting-${JNLP_VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

COPY files/jenkins-slave /usr/local/bin/jenkins-slave
RUN chmod 755 /usr/local/bin/jenkins-slave

ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins -s /bin/bash

RUN groupmod -g ${DOCKER_GID} docker
RUN gpasswd -a jenkins docker

USER jenkins
WORKDIR /home/jenkins

CMD /usr/local/bin/jenkins-slave
