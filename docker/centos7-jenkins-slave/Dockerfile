FROM centos:7

ARG MAVEN_VERSION=3.6.1
ARG DOCKER_GID=992
ARG KUBE_VERSION=1.10.2
ARG COMPOSE_VERSION=1.24.0

ADD files/setup.sh /
COPY files/igi-test-ca.pem /etc/pki/ca-trust/source/anchors/
RUN chmod +x /setup.sh
RUN update-ca-trust /setup.sh

RUN MAVEN_VERSION=$MAVEN_VERSION \
      DOCKER_GID=$DOCKER_GID \
      KUBE_VERSION=$KUBE_VERSION \
      COMPOSE_VERSION=$COMPOSE_VERSION \
      /setup.sh
ENV HOME /home/jenkins
USER jenkins

RUN kubectl config set-cluster mwdevel --certificate-authority=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
RUN kubectl config set-credentials jenkinsci --token=/var/run/secrets/kubernetes.io/serviceaccount/token

WORKDIR /home/jenkins

CMD /usr/bin/cat
