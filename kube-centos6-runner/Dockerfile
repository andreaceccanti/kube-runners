FROM centos:centos6

ARG JNLP_VERSION=3.7

RUN yum install -y http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
RUN yum install -y http://repository.egi.eu/sw/production/umd/3/sl6/x86_64/updates/umd-release-3.14.3-1.el6.noarch.rpm

RUN yum --enablerepo=centosplus install -y epel-release 
RUN yum --disablerepo=*UMD* install -y gsoap-devel

RUN yum install -y argus-pep-api-c argus-pep-api-c-devel automake boost-devel CGSI-gSOAP-devel createrepo curl-devel \
	gcc gcc-c++ globus-gssapi-gsi-devel globus-gss-assist-devel globus-common-devel globus-gridmap-callout-error-devel \
	globus-gsi-credential-devel globus-gridftp-server-devel globus-ftp-control-devel globus-ftp-client-devel gettext git \
	java-1.8.0-openjdk java-1.8.0-openjdk-devel jq krb5-devel libuuid-devel libtool libattr-devel libuuid-devel m4 mysql-devel \
	openssl-devel pkgconfig puppet repoview rpmdevtools rsync redhat-lsb storm-xmlrpc-c-devel wget tar unzip wget voms zlib && \
	yum clean all

RUN puppet module install --force maestrodev-wget && \
    puppet module install --force puppetlabs-stdlib

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
