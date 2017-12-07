FROM centos:7

RUN yum install -y epel-release && \
    yum install -y https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm && \
    yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel git wget which gettext rsync unzip jq createrepo repoview rpmdevtools puppet-agent make && \
    yum clean all
    
COPY files/igi-test-ca.pem /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust

RUN wget -O /tmp/sonar-scanner.zip https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-2.9.0.670.zip \
    && unzip /tmp/sonar-scanner.zip -d /opt \
    && mv /opt/sonar-scanner-2.9.0.670 /opt/sonar-scanner \
    && echo 'export PATH=$PATH:/opt/sonar-scanner/bin/' >> /etc/bashrc
    
RUN wget -O /usr/local/bin/nexus-assets-list https://raw.githubusercontent.com/marcocaberletti/scripts/master/bin/nexus-assets-list \
    && wget -O /usr/local/bin/nexus-assets-remove https://raw.githubusercontent.com/marcocaberletti/scripts/master/bin/nexus-assets-remove \
    && wget -O /usr/local/bin/nexus-assets-upload https://raw.githubusercontent.com/marcocaberletti/scripts/master/bin/nexus-assets-upload \
    && chmod +x /usr/local/bin/nexus-assets-*

ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins -s /bin/bash

USER jenkins

WORKDIR /home/jenkins

CMD /usr/bin/cat
