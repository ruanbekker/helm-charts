# credit: https://github.com/chrisrun

FROM buildpack-deps:buster-curl as builder
ENV a=a
ARG VERSION=28.0

RUN apt update && apt install gnupg2 curl -y && \
    rm -rf /var/lib/apt/lists/*

COPY ./get_software.sh /usr/bin/
RUN chmod +x /usr/bin/get_software.sh && \
    mkdir /root/bitcoin && \
    get_software.sh $VERSION /root/bitcoin/

#FROM debian:buster-slim
FROM debian:stable-20241016

ARG UID=1000
ARG GID=1000
ARG USERNAME=bitcoin

#RUN apt update && apt install iproute2 sudo procps net-tools libc6 libc6-dev libpthread-stubs0-dev -y && \
RUN apt update && apt install iproute2 sudo procps net-tools -y && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g $GID -o $USERNAME && \
    useradd -m -u $UID -g $GID -o -d /home/$USERNAME -s /bin/bash $USERNAME

COPY --from=builder /root/bitcoin/ /usr/local/
COPY ./entrypoint.sh /usr/local/entrypoint.sh
RUN chmod a+rx /usr/local/entrypoint.sh && \
    mkdir -p /bitcoin/data && \
    chown -R $USERNAME:$GID /bitcoin

USER $USERNAME

EXPOSE 8332 8333 18332 18333 28332 28333

ENTRYPOINT ["/usr/local/entrypoint.sh"]
