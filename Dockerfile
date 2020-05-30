FROM openjdk:8u212-jdk-alpine as builder

RUN apk --no-cache add curl \
    && mkdir -p /opt/ && cd /opt/ \
    && curl -sSfL https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -o apache-maven-3.6.3-bin.tar.gz \
    && tar xzvf apache-maven-3.6.3-bin.tar.gz \
    && rm -rf apache-maven-3.6.3-bin.tar.gz

ENV MAVEN_HOME=/opt/apache-maven-3.6.3
ENV PATH=$PATH:$MAVEN_HOME/bin

WORKDIR /home/app

COPY . /home/app

RUN mvn clean package

FROM openfaas/of-watchdog:0.7.6 as watchdog

FROM openjdk:8u212-jdk-alpine as ship

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog

RUN chmod +x /usr/bin/fwatchdog

WORKDIR /home/app

COPY --from=builder /home/app/target/java-tmp-0.0.1-SNAPSHOT.jar ./java-tmp-0.0.1-SNAPSHOT.jar


CMD java -jar -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap java-tmp-0.0.1-SNAPSHOT.jar