FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/user

RUN apt update && apt install -y \
    ttyd bash login iputils-ping curl dnsutils netcat-traditional python3-minimal && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Create a simple non-root user
RUN useradd -m -s /bin/bash user && \
    echo 'Welcome to NetProbe CloudShell (beta)' > /etc/motd

WORKDIR /
CMD ["ttyd", "-p", "7681", "-i", "0.0.0.0", "login", "-f", "user"]
