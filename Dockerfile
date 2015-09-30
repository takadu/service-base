FROM takadu/ubuntu-base:latest

MAINTAINER Adi Baron <adi.baron@takadu.com>

ENV JVM_MAJ 8
ENV JVM_MID 60
ENV JVM_MIN 27

ENV DOWNLOAD_URL "http://download.oracle.com/otn-pub/java/jdk"

ENV JAVA_HOME /usr/lib/jvm/${JVM_MAJ}.${JVM_MID}

RUN curl \
    --silent \
    --location \
    --retry 3 \
    --cacert /etc/ssl/certs/GeoTrust_Global_CA.pem \
    --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
    "${DOWNLOAD_URL}"/"${JVM_MAJ}"u"${JVM_MID}"-b"${JVM_MIN}"/jdk-"${JVM_MAJ}"u"${JVM_MID}"-linux-x64.tar.gz \
    | tar xz -C /tmp

RUN mkdir -p /usr/lib/jvm && mv /tmp/jdk1.${JVM_MAJ}.0_${JVM_MID} "${JAVA_HOME}"

RUN update-alternatives --install "/usr/bin/java" "java" "${JAVA_HOME}/bin/java" 1 && \
    update-alternatives --install "/usr/bin/javaws" "javaws" "${JAVA_HOME}/bin/javaws" 1 && \
    update-alternatives --install "/usr/bin/javac" "javac" "${JAVA_HOME}/bin/javac" 1 && \
    update-alternatives --set java "${JAVA_HOME}/bin/java" && \
    update-alternatives --set javaws "${JAVA_HOME}/bin/javaws" && \
    update-alternatives --set javac "${JAVA_HOME}/bin/javac"
