# Base Image
FROM docker.io/haproxytech/haproxy-ubuntu-quic:3.2 as builder

# Maintainer
LABEL maintainer="Yongbok Kim"

# Default directory
WORKDIR /opt

# Variables
ARG TARGETARCH=amd64

# Install Packages
RUN apt update \
 && apt install -y python3-pip iproute2 \
 && pip3 install jinja2

# Copy files
COPY conf/generate.py /usr/local/bin/generate.py

# Init Directory
RUN mkdir /haproxy \
 && chown -R 1000:1000 /haproxy \
 && chmod -R 777 /haproxy

# User
USER root

# Expose Ports
EXPOSE 1936/tcp 6379/tcp

# Start
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/local/sbin/haproxy", "-f", "/haproxy/haproxy.cfg"]
