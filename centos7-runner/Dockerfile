FROM centos:7

ARG DOCKER_GID=992
ARG KUBE_VERSION=1.10.2

RUN yum install -y epel-release && \
    yum install -y https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm && \
    yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel git wget which gettext rsync unzip jq createrepo repoview rpmdevtools puppet-agent make && \
    yum clean all
    
COPY files/igi-test-ca.pem /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust

RUN wget -O /tmp/sonar-scanner.zip https://dl.bintray.com/sonarsource/SonarQube/org/sonarsource/scanner/cli/sonar-scanner-cli/2.9.0.670/sonar-scanner-cli-2.9.0.670.zip \
    && unzip /tmp/sonar-scanner.zip -d /opt \
    && mv /opt/sonar-scanner-2.9.0.670 /opt/sonar-scanner \
    && echo 'export PATH=$PATH:/opt/sonar-scanner/bin/' >> /etc/bashrc
    
RUN wget -O /usr/local/bin/nexus-assets-list https://raw.githubusercontent.com/marcocaberletti/scripts/master/bin/nexus-assets-list \
    && wget -O /usr/local/bin/nexus-assets-remove https://raw.githubusercontent.com/marcocaberletti/scripts/master/bin/nexus-assets-remove \
    && wget -O /usr/local/bin/nexus-assets-upload https://raw.githubusercontent.com/marcocaberletti/scripts/master/bin/nexus-assets-upload \
    && chmod +x /usr/local/bin/nexus-assets-*

RUN wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip -O terraform.zip \
    && unzip terraform.zip \
    && rm -f terraform.zip \
    && mv terraform /usr/local/bin \
    && chmod +x /usr/local/bin/terraform \
    && terraform -v

RUN yum group install "Development Tools" -y \
    yum clean all

RUN yum install python-devel python-setuptools python-wheel python-pip -y \
    yum clean all \
    && pip install python-openstackclient \
    && openstack --version

# Maven deps
RUN yum install -y maven 

# Docker & Docker-compose 
RUN yum install -y yum-utils && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum install -y docker-ce && yum clean all

RUN curl -L "https://github.com/docker/compose/releases/download/1.19.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Kubectl
#
RUN wget -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl \
  && chmod +x /usr/local/bin/kubectl

ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins -s /bin/bash

RUN groupmod -g ${DOCKER_GID} docker
RUN gpasswd -a jenkins docker

USER jenkins

RUN kubectl config set-cluster mwdevel --certificate-authority=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
RUN kubectl config set-credentials jenkinsci --token=/var/run/secrets/kubernetes.io/serviceaccount/token

WORKDIR /home/jenkins

CMD /usr/bin/cat
