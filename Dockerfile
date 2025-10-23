# Project Cloudshell Prototype Dockerfile

# Stage 1: Earliest prototype
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y ttyd bash curl && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Simple startup command: run ttyd with bash (no login, no user)
CMD ["ttyd", "-p", "7681", "-i", "0.0.0.0", "bash"]
