FROM centos:7

ARG KUBE_VERSION=1.10.2

RUN yum install -y git wget gettext rsync && \
    yum clean all

RUN wget -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl \
  && chmod +x /usr/local/bin/kubectl

ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins -s /bin/bash

USER jenkins

RUN kubectl config set-cluster mwdevel --certificate-authority=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
RUN kubectl config set-credentials jenkinsci --token=/var/run/secrets/kubernetes.io/serviceaccount/token

WORKDIR /home/jenkins

CMD /usr/bin/cat
