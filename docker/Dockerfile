FROM ubuntu:22.04

EXPOSE 8080 9100

ENV DEBIAN_FRONTEND=noninteractive

# kubectl & curl
RUN apt update && \
    apt install -y curl ca-certificates jq bash && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.26.7/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/bin/kubectl

# Algorand node
RUN mkdir /algorand
WORKDIR /algorand
SHELL ["/bin/bash", "-c"]
RUN curl -L https://raw.githubusercontent.com/algorand/go-algorand/rel/stable/cmd/updater/update.sh --output ./update.sh && \
    chmod -v 744 ./update.sh && \
    mkdir node && \
    ./update.sh -i -c stable -p node -d node/_data -n && \
    rm -rf node/_data

ADD ./scripts ./

# USER 10001:10001
