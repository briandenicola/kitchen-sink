FROM mcr.microsoft.com/azure-powershell:latest

ARG HELM=3.8.0
ARG FLUX=0.31.1
ARG DS=3.5.9
ARG VAULT=1.10.3
ARG TERRAFORM=1.2.2
ARG KUBELOGIN=0.0.13
ARG ISTIO=1.14.1

RUN apt-get update \
  && apt-get install --no-install-recommends --yes \
    wget \
    unzip \ 
    curl 

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin 

RUN curl -sSL https://get.helm.sh/helm-v${HELM}-linux-amd64.tar.gz -o /tmp/helm.tar.gz  \
    && tar -zxf /tmp/helm.tar.gz -C /tmp \
    && mv /tmp/linux-amd64/helm /usr/local/bin \
    && rm -f /tmp/helm.tar.gz \
    && rm -rf /tmp/linux-amd64

RUN curl -sSL https://aka.ms/downloadazcopy-v10-linux -o /tmp/azcopy.tar.gz \
    && tar -xzf /tmp/azcopy.tar.gz -C /tmp \
    && mv /tmp/azcopy_linux_amd64_*/azcopy /usr/local/bin \
    && rm -rf /tmp/azcopy*

RUN curl -sSL "https://github.com/fluxcd/flux2/releases/download/v${FLUX}/flux_${FLUX}_linux_amd64.tar.gz" -o /tmp/flux2.tar.gz \
    && tar -xf /tmp/flux2.tar.gz -C /tmp \
    && mv /tmp/flux /usr/local/bin \
    && rm -f /tmp/flux.tar.gz 
 
RUN curl -sSL "https://github.com/briandenicola/directory-size/releases/download/${DS}/directorysize-linux-x64.tar.gz" -o /tmp/ds.tar.gz \
    && tar -xf /tmp/ds.tar.gz -C /tmp \
    && mv /tmp/publish/DirectorySize /usr/local/bin/directorysize \
    && rm -rf /tmp/ds.tar.gz

RUN curl -sSL "https://releases.hashicorp.com/vault/${VAULT}/vault_${VAULT}_linux_amd64.zip" -o /tmp/vault.zip \
    && unzip /tmp/vault.zip -d /tmp \
    && mv /tmp/vault /usr/local/bin/vault \
    && rm -f /tmp/vault.zip

RUN curl -sSL "https://releases.hashicorp.com/terraform/${TERRAFORM}/terraform_${TERRAFORM}_linux_amd64.zip" -o /tmp/terraform.zip \
    && unzip /tmp/terraform.zip -d /tmp \
    && mv /tmp/terraform /usr/local/bin/terraform \
    && rm -f /tmp/terraform.zip

RUN curl -sSL https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64 -o /usr/local/bin/hey \
    && chmod +x /usr/local/bin/hey

RUN wget -q https://raw.githubusercontent.com/dapr/cli/master/install/install.sh -O - | /bin/bash

RUN curl -LO "https://github.com/Azure/kubelogin/releases/download/v${KUBELOGIN}/kubelogin-linux-amd64.zip" \
    && unzip kubelogin-linux-amd64.zip \ 
    && chmod +x ./bin/linux_amd64/kubelogin \
    && mv ./bin/linux_amd64/kubelogin  /usr/local/bin \ 
    && rm -rf ./kubelogin-linux-amx64.zip \
    && rm -rf ./bin/linux_amd64

RUN curl -sSL "https://github.com/istio/istio/releases/download/${ISTIO}/istio-${ISTIO}-linux-amd64.tar.gz" -o /tmp/istio.tar.gz \
    && tar -xf /tmp/istio.tar.gz -C /tmp \
    && mv /tmp/istio-${ISTIO}/bin/istioctl /usr/local/bin \ 
    && rm -f /tmp/istio-${ISTIO}.tar.gz \
    && rm -rf tmp/istio-${ISTIO}

RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb

RUN apt-get update \
  && apt-get install --no-install-recommends --yes \
    locales \
    git \
    dnsutils \
    jq \
    net-tools \
    redis-tools \
    vim \
    iproute2 \
    nmap \
    python3 \
    python3-pip \
    traceroute \
    netcat \
    ca-certificates  \
    nmon \  
    procmon \ 
    slurm 

COPY ca-certificates.crt /etc/ssl/certs/
COPY sleep.sh /bin/sleep.sh

RUN chmod a+x /bin/sleep.sh 
ENTRYPOINT ["/bin/sleep.sh"]