FROM ubuntu:16.04

ARG JNLP_VERSION=3.7

RUN apt-get update -y && \
    apt-get install -y openjdk-8-jdk maven git wget curl jq dpkg-dev && \
    apt-get clean

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${JNLP_VERSION}/remoting-${JNLP_VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar
  
COPY files/igi-test-ca.pem /usr/local/share/ca-certificates/
RUN update-ca-certificates

COPY files/jenkins-slave /usr/local/bin/jenkins-slave
RUN chmod 755 /usr/local/bin/jenkins-slave

ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins -s /bin/bash

USER jenkins

WORKDIR /home/jenkins

CMD /usr/local/bin/jenkins-slave
