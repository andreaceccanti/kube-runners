FROM fedora:latest

RUN dnf install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel maven git wget gettext rsync curl jq svn && \
    dnf clean all

COPY files/igi-test-ca.pem /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust

ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins -s /bin/bash

USER jenkins
WORKDIR /home/jenkins

CMD /usr/bin/cat
