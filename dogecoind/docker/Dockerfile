# credit: https://github.com/chrisrun

FROM buildpack-deps:buster-curl as builder
ARG VERSION=1.14.6

RUN apt update && apt install gnupg2 curl -y && \
    rm -rf /var/lib/apt/lists/*

COPY ./get_software.sh /usr/bin/
RUN chmod +x /usr/bin/get_software.sh && \
    mkdir /root/dogecoin && \
    get_software.sh $VERSION /root/dogecoin/

FROM debian:buster-slim

ARG UID=1000
ARG GID=1000
ARG USERNAME=dogecoin

RUN apt update && apt install iproute2 sudo procps net-tools -y && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g $GID -o $USERNAME && \
    useradd -m -u $UID -g $GID -o -d /home/$USERNAME -s /bin/bash $USERNAME

COPY --from=builder /root/dogecoin/ /usr/local/
COPY ./entrypoint.sh /usr/local/entrypoint.sh
RUN chmod a+rx /usr/local/entrypoint.sh && \
    mkdir -p /dogecoin/data && \
    chown -R $USERNAME:$GID /dogecoin

USER $USERNAME

EXPOSE 9332 9333 18332 18333 28332 28333

ENTRYPOINT ["/usr/local/entrypoint.sh"]