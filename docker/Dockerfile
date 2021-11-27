FROM ubuntu:16.04

EXPOSE 8080 9100

# kubectl
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl && \
    curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubectl

# Algorand node
RUN mkdir /algorand
WORKDIR /algorand
RUN apt-get update && \
    apt-get install --no-install-recommends -y -q curl build-essential ca-certificates git mercurial runit vim && \
    curl -L https://github.com/algorand/go-algorand-doc/raw/master/downloads/installers/linux_amd64/install_master_linux-amd64.tar.gz --output /algorand/install_master_linux-amd64.tar.gz && \
    tar -xf install_master_linux-amd64.tar.gz && \
    mkdir node && \
    ./update.sh -i -c stable -p node -d node/_data -n && rm -rf node/_data

ADD ./scripts ./
