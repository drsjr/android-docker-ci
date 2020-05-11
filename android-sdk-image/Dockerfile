FROM ubuntu:18.04

RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends libncurses5:i386 libc6:i386 libstdc++6:i386 lib32gcc1 lib32ncurses5 lib32z1 zlib1g:i386 && \
    apt-get install -y --no-install-recommends openjdk-8-jdk && \
    apt-get install -y --no-install-recommends wget unzip git && \
    apt-get install -y --no-install-recommends qt5-default


ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV ANDROID_HOME /opt/android-sdk

ARG  ANDROID_SDK_VERSION=6200805_latest

RUN mkdir -p ${ANDROID_HOME} && cd ${ANDROID_HOME} && \
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_VERSION}.zip && \
    unzip commandlinetools*.zip && \
    rm commandlinetools*.zip

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin
ENV LD_LIBRARY_PATH ${ANDROID_HOME}/emulator/lib64:${ANDROID_HOME}/emulator/lib64/qt/lib

ADD licenses_accepter.sh /opt/
RUN chmod +x /opt/licenses_accepter.sh && /opt/licenses_accepter.sh ${ANDROID_HOME}

EXPOSE 22
ADD sshd-banner /etc/ssh
ADD authorized_keys /tmp/
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openssh-server supervisor locales && \
    mkdir -p /var/run/sshd /var/log/supervisord && \
    locale-gen en en_US en_US.UTF-8 && \
    apt-get remove -y locales && apt-get autoremove -y && \
    FILE_SSHD_CONFIG="/etc/ssh/sshd_config" && \
    echo "\nBanner /etc/ssh/sshd-banner" >> $FILE_SSHD_CONFIG && \
    echo "\nPermitUserEnvironment=yes" >> $FILE_SSHD_CONFIG && \
    ssh-keygen -q -N "" -f /root/.ssh/id_rsa && \
    FILE_SSH_ENV="/root/.ssh/environment" && \
    touch $FILE_SSH_ENV && chmod 600 $FILE_SSH_ENV && \
    printenv | grep "JAVA_HOME\|ANDROID_HOME\|PATH" >> $FILE_SSH_ENV && \
    FILE_AUTH_KEYS="/root/.ssh/authorized_keys" && \
    touch $FILE_AUTH_KEYS && chmod 600 $FILE_AUTH_KEYS && \
    for file in /tmp/*.pub; \
    do if [ -f "$file" ]; then echo "\n" >> $FILE_AUTH_KEYS && cat $file >> $FILE_AUTH_KEYS && echo "\n" >> $FILE_AUTH_KEYS; fi; \
    done && \
    (rm /tmp/*.pub 2> /dev/null || true)

ADD supervisord.conf /etc/supervisor/conf.d/
CMD ["/usr/bin/supervisord"]

# setup adb server
EXPOSE 5037

