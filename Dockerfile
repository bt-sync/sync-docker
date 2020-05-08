# Resilio Sync
#
# VERSION               0.1
#

FROM ubuntu
MAINTAINER Resilio Inc. <support@resilio.com>
LABEL com.resilio.version="2.7.0"

ADD https://download-cdn.resilio.com/2.7.0/linux-x64/resilio-sync_x64.tar.gz /tmp/sync.tgz
RUN tar -xf /tmp/sync.tgz -C /usr/bin rslsync && rm -f /tmp/sync.tgz

COPY sync.conf.default /etc/
COPY run_sync /usr/bin/

# webui port
EXPOSE 8888/tcp

# listening port
EXPOSE 55555/tcp

# listening port
EXPOSE 55555/udp  

# More info about ports used by Sync you can find here:
# https://help.resilio.com/hc/en-us/articles/204754759-What-ports-and-protocols-are-used-by-Sync-

VOLUME /mnt/sync

ENTRYPOINT ["run_sync"]
CMD ["--config", "/mnt/sync/sync.conf"]
