FROM openjdk:8
LABEL maintainer="Juan Pablo Crespi <juanpablocrespi99@gmail.com>"

RUN apt-get update
RUN apt-get install -y curl git tmux htop maven sudo

ARG SONAR_SCANNER_VERSION="4.0.0.1744"
ENV SONAR_URL="https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip"

WORKDIR /usr/src

RUN curl -o ./sonarscanner.zip -L $SONAR_URL
RUN unzip sonarscanner.zip 
RUN rm sonarscanner.zip
RUN mv sonar-scanner-$SONAR_SCANNER_VERSION-linux /usr/lib/sonar-scanner
RUN ln -s /usr/lib/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner

ENV SONAR_RUNNER_HOME=/usr/lib/sonar-scanner
RUN sonar-scanner -v