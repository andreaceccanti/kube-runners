FROM fedora:latest

ARG JNLP_VERSION=2.62

RUN dnf install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel maven git wget gettext rsync && \
    dnf clean all

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${JNLP_VERSION}/remoting-${JNLP_VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

COPY files/igi-test-ca.pem /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust
RUN ln -s /etc/pki/java/cacerts /usr/lib/jvm/jre/lib/security/cacerts

COPY files/jenkins-slave /usr/local/bin/jenkins-slave
RUN chmod 755 /usr/local/bin/jenkins-slave

ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins -s /bin/bash

USER jenkins

CMD /usr/local/bin/jenkins-slave
