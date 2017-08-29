FROM centos:7

ARG JNLP_VERSION=3.7

RUN yum install -y epel-release && \
	yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel git wget which gettext rsync unzip jq createrepo repoview rpmdevtools
    
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash && \
	yum install -y git-lfs && \
	git lfs install && \
	yum clean all

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${JNLP_VERSION}/remoting-${JNLP_VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar
  
COPY files/igi-test-ca.pem /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust

COPY files/jenkins-slave /usr/local/bin/jenkins-slave
RUN chmod 755 /usr/local/bin/jenkins-slave

RUN wget -O /tmp/sonar-scanner.zip https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-2.9.0.670.zip \
    && unzip /tmp/sonar-scanner.zip -d /opt \
    && mv /opt/sonar-scanner-2.9.0.670 /opt/sonar-scanner \
    && echo 'export PATH=$PATH:/opt/sonar-scanner/bin/' >> /etc/bashrc

ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins -s /bin/bash

USER jenkins

WORKDIR /home/jenkins

CMD /usr/local/bin/jenkins-slave
