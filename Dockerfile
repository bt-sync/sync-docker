# Resilio Sync
#
# VERSION               0.1
#

ARG FROM_ARCH=amd64

FROM alpine AS builder

ARG VERSION=2.7.2
ARG ARCH=x64
ADD https://download-cdn.resilio.com/${VERSION}/linux-${ARCH}/resilio-sync_${ARCH}.tar.gz resilio-sync.tar.gz
RUN tar zxvf resilio-sync.tar.gz


FROM ${FROM_ARCH}/ubuntu

LABEL maintainer="Resilio Inc. <support@resilio.com>"
LABEL com.resilio.version="2.7.2"

COPY --from=builder rslsync /usr/bin
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
