FROM java:8-jdk

ARG SCALA_VERSION=2.12.8

USER root

# Install scala
RUN \
    mkdir -p /opt/scala/bin && \
    cd /opt && \
    wget -q -O- --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 \
      "https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" | \
      tar -xz --strip 1 -C /opt/scala/ && \
    ln -s /opt/scala/bin/scala /bin/scala && \
    ln -s /opt/scala/bin/scalac /bin/scalac

# Install sbt
RUN \
    wget https://github.com/sbt/sbt/releases/download/v0.13.15/sbt-0.13.15.tgz && \
    tar zxvf sbt-0.13.15.tgz && \
    mv sbt /opt && \
    rm sbt-0.13.15.tgz
ENV SBT_HOME /opt/sbt
ENV PATH $PATH:/opt/sbt/bin


#ENTRYPOINT ["/bin/scala"]