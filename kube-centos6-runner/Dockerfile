FROM centos:centos6

ARG JNLP_VERSION=3.7

RUN rpm --import http://mirror.centos.org/centos/6/os/x86_64/RPM-GPG-KEY-CentOS-6
RUN rpm --import http://mirror.centos.org/centos/6/os/x86_64/RPM-GPG-KEY-CentOS-Debug-6
RUN rpm --import http://mirror.centos.org/centos/6/os/x86_64/RPM-GPG-KEY-CentOS-Testing-6
RUN rpm --import http://mirror.centos.org/centos/6/os/x86_64/RPM-GPG-KEY-CentOS-Security-6

RUN yum clean all
RUN yum -y update

RUN rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

RUN yum --enablerepo=centosplus install -y epel-release redhat-lsb wget git tar puppet

RUN puppet module install --force maestrodev-wget && \
    puppet module install --force puppetlabs-stdlib

RUN rpm --import http://repository.egi.eu/sw/production/umd/UMD-RPM-PGP-KEY
RUN yum install -y http://repository.egi.eu/sw/production/umd/3/sl6/x86_64/updates/umd-release-3.14.3-1.el6.noarch.rpm

RUN yum install -y \
  automake \
  redhat-lsb \
  git \
  wget \
  java-1.8.0-openjdk \
  java-1.8.0-openjdk-devel \
  gettext \
  rsync \
  unzip \
  jq \
  createrepo \
  repoview \
  rpmdevtools \
  libuuid-devel \
  boost-devel \
  pkgconfig \
  curl-devel \
  mysql-devel \
  globus-gssapi-gsi-devel \
  globus-gss-assist-devel \
  globus-common-devel \
  globus-gridmap-callout-error-devel \
  globus-gsi-credential-devel \
  krb5-devel \
  gsoap-devel \
  CGSI-gSOAP-devel \
  libuuid-devel \
  voms \
  gcc \
  gcc-c++ \
  storm-xmlrpc-c-devel \
  argus-pep-api-c \
  argus-pep-api-c-devel

RUN yum clean all

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${JNLP_VERSION}/remoting-${JNLP_VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar
  
COPY files/igi-test-ca.pem /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust

COPY files/jenkins-slave /usr/local/bin/jenkins-slave
RUN chmod 755 /usr/local/bin/jenkins-slave

ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins -s /bin/bash

USER jenkins

WORKDIR /home/jenkins

CMD /usr/local/bin/jenkins-slave
