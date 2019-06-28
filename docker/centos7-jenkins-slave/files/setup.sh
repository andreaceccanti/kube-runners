#!/bin/bash
set -ex

export MAVEN_VERSION=${MAVEN_VERSION:-3.61}
export DOCKER_GID=${DOCKER_GID:-992}
export KUBE_VERSION=${KUBE_VERSION:-1.10.2}
export COMPOSE_VERSION=${COMPOSE_VERSION:-1.24.0}

yum install -y epel-release
yum install -y https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm
yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel git wget which gettext rsync unzip jq createrepo repoview rpmdevtools puppet-agent make
    
# Sonar scanner
wget -O /tmp/sonar-scanner.zip https://dl.bintray.com/sonarsource/SonarQube/org/sonarsource/scanner/cli/sonar-scanner-cli/2.9.0.670/sonar-scanner-cli-2.9.0.670.zip 
unzip /tmp/sonar-scanner.zip -d /opt 
mv /opt/sonar-scanner-2.9.0.670 /opt/sonar-scanner 
echo 'export PATH=$PATH:/opt/sonar-scanner/bin/' >> /etc/bashrc 

# Terraform
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip -O terraform.zip 
unzip terraform.zip
rm -f terraform.zip
mv terraform /usr/local/bin
chmod +x /usr/local/bin/terraform
terraform -v

# Openstack CLI
yum -y group install "Development Tools"
yum -y install python-devel python-setuptools python-wheel python-pip
pip install python-openstackclient
openstack --version 

# Maven
mkdir /opt/maven 
curl -L "http://mirror.nohup.it/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" -o /opt/maven/apache-maven-${MAVEN_VERSION}-bin.tar.gz  
cd /opt/maven && tar xvzf apache-maven-${MAVEN_VERSION}-bin.tar.gz && cd 
alternatives --install /usr/bin/mvn mvn /opt/maven/apache-maven-${MAVEN_VERSION}/bin/mvn 1
alternatives --auto mvn 

# Docker & Docker-compose
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Kubectl
wget -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl
chmod +x /usr/local/bin/kubectl

# Jenkins user setup
groupadd -g 10000 jenkins
useradd -c "Jenkins user" -d /home/jenkins -u 10000 -g 10000 -m jenkins -s /bin/bash

# Docker groups
groupmod -g ${DOCKER_GID} docker
gpasswd -a jenkins docker
