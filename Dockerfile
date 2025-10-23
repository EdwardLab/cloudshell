FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/user

RUN apt update && apt install -y \
    ttyd bash login iputils-ping traceroute curl dnsutils whois \
    netcat-traditional python3-minimal cron mtr openssh-client net-tools && \
    apt clean && rm -rf /var/lib/apt/lists/*

RUN echo 'unset HISTFILE' >> /etc/skel/.bashrc && \
    echo '( sleep 300 && kill -9 $$ ) &' >> /etc/skel/.bashrc && \
    echo 'TMOUT=300' >> /etc/skel/.bashrc

RUN useradd -m -s /bin/bash user && \
    chown -R user:user /home/user

RUN echo 'netprobe-cloudshell' > /etc/hostname
RUN echo 'PRETTY_NAME="NetProbe CloudShell Linux"' > /etc/os-release

RUN echo '#!/bin/bash\n\
pkill -u user || true\n\
rm -rf /tmp/* /home/user/tmp/* 2>/dev/null || true' > /usr/local/bin/cleanup.sh && \
    chmod +x /usr/local/bin/cleanup.sh && \
    echo '0 * * * * root /usr/local/bin/cleanup.sh' >> /etc/crontab

RUN rm -rf /etc/update-motd.d/* && \
    > /etc/legal && \
    echo 'Welcome to NetProbe CloudShell\n\nThis tool allows you to perform network probing and diagnostics.\n' > /etc/motd && \
    sed -i '/pam_motd.so/d' /etc/pam.d/login && \
    echo 'session optional pam_motd.so motd=/etc/motd' >> /etc/pam.d/login

RUN rm -f /bin/df /usr/bin/free /usr/bin/sudo /usr/bin/apt /usr/bin/lsblk \
  /usr/bin/mount /usr/bin/lscpu /usr/bin/uptime /usr/bin/dmesg /usr/bin/uname \
  /bin/su /usr/bin/ifconfig /usr/bin/ps /usr/bin/dpkg /usr/bin/top /usr/bin/nohup /usr/bin/kill \
  /usr/bin/w /usr/bin/who /usr/bin/last /usr/bin/id /usr/bin/stat /usr/bin/systemctl /usr/bin/sleep || true

WORKDIR /
RUN mv /usr/bin/ttyd /usr/local/bin/._ttyd_launcher
CMD service cron start && /usr/local/bin/._ttyd_launcher -p 7681 -i 0.0.0.0 -W login -f user
