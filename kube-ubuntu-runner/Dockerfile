FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y openjdk-8-jdk maven git wget curl jq dpkg-dev && \
    apt-get clean

COPY files/igi-test-ca.pem /usr/local/share/ca-certificates/
RUN update-ca-certificates

ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins -s /bin/bash

USER jenkins

WORKDIR /home/jenkins

CMD /usr/bin/cat
