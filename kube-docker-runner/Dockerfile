FROM centos:7

ARG DOCKER_GID=994

RUN yum install -y yum-utils && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum install -y git wget gettext rsync docker-ce && \
    yum clean all

RUN curl -L "https://github.com/docker/compose/releases/download/1.17.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins -s /bin/bash

RUN groupmod -g ${DOCKER_GID} docker
RUN gpasswd -a jenkins docker

USER jenkins
WORKDIR /home/jenkins

CMD /usr/bin/cat
