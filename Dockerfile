FROM openjdk:8-slim
MAINTAINER Andrew Ripa <ripa.andrew@gmail.com>

USER root
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install wget git sudo

RUN groupadd -g 995 jenkins
RUN useradd -u 997 -s "/bin/bash" -g jenkins jenkins
RUN usermod -aG sudo jenkins
RUN echo "jenkins ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip"
ENV ANDROID_SDK_LICENSE="\nd56f5187479451eabf01fb78af6dfcb131a6481e"
ENV ANDROID_HOME=/androidhome

RUN mkdir -p "${ANDROID_HOME}/licenses"
RUN wget ${ANDROID_SDK_URL} \
    -O sdk.zip \
    && unzip sdk.zip -d ${ANDROID_HOME} \
    && rm sdk.zip

RUN echo ${ANDROID_SDK_LICENSE} > "${ANDROID_HOME}/licenses/android-sdk-license"

RUN ${ANDROID_HOME}/tools/bin/sdkmanager --verbose \
    "platform-tools"

RUN chown -R jenkins:jenkins /androidhome && chown -R jenkins:jenkins /android

USER jenkins

WORKDIR /android/src
# RUN chown -R jenkins:jenkins /android && chown -R jenkins:jenkins /androidhome
