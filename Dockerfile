# Resilio Sync
#
# VERSION               0.1

FROM ubuntu:15.04
MAINTAINER Resilio Inc. <support@resilio.com>
LABEL com.resilio.version="2.4.0"

ADD https://download-cdn.resilio.com/stable/linux-x64/resilio-sync_x64.tar.gz /tmp/sync.tgz
RUN tar -xf /tmp/sync.tgz -C /usr/sbin rslsync && rm -f /tmp/sync.tgz

COPY sync.conf /etc/
COPY run_sync /opt/

EXPOSE 8888
EXPOSE 55555

VOLUME /mnt/sync

ENTRYPOINT ["/opt/run_sync"]
CMD ["--log", "--config", "/etc/btsync.conf"]
