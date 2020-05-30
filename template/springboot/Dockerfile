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

ENV upstream_url="http://127.0.0.1:8082"
ENV mode="http"
ENV fprocess="java -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap com.openfaas.entrypoint.App"

EXPOSE 8080

HEALTHCHECK --interval=5s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]