FROM openjdk:8-slim
MAINTAINER Andrew Ripa <ripa.andrew@gmail.com>

USER root

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install wget git sudo

RUN groupadd -g 995 jenkins
RUN useradd -u 997 -s "/bin/bash" -g jenkins jenkins
RUN usermod -aG sudo jenkins
RUN echo "jenkins ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

USER jenkins

ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip"
ENV ANDROID_SDK_LICENSE="\nd56f5187479451eabf01fb78af6dfcb131a6481e"
ENV ANDROID_HOME=/androidhome

RUN sudo mkdir -p "${ANDROID_HOME}/licenses"
RUN sudo wget ${ANDROID_SDK_URL} \
    -O sdk.zip \
    && sudo unzip sdk.zip -d ${ANDROID_HOME} \
    && sudo rm sdk.zip

RUN sudo touch ${ANDROID_HOME}/licenses/android-sdk-license && echo -e ${ANDROID_SDK_LICENSE} > \
    "${ANDROID_HOME}/licenses/android-sdk-license"


RUN ${ANDROID_HOME}/tools/bin/sdkmanager --verbose \
    "platform-tools"

WORKDIR /android/src
# RUN chown -R jenkins:jenkins /android && chown -R jenkins:jenkins /androidhome
