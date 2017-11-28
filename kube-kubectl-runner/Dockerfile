FROM centos:7

ARG JNLP_VERSION=3.7
ARG KUBE_VERSION=1.8.4

RUN yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel git wget gettext rsync && \
    yum clean all

RUN wget -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl \
  && chmod +x /usr/local/bin/kubectl

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${JNLP_VERSION}/remoting-${JNLP_VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

COPY files/jenkins-slave /usr/local/bin/jenkins-slave
RUN chmod 755 /usr/local/bin/jenkins-slave

ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins -s /bin/bash

USER jenkins

RUN kubectl config set-cluster mwdevel --certificate-authority=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
RUN kubectl config set-credentials jenkinsci --token=/var/run/secrets/kubernetes.io/serviceaccount/token

WORKDIR /home/jenkins

CMD /usr/local/bin/jenkins-slave
