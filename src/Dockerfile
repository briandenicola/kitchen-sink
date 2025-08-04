FROM mcr.microsoft.com/azure-powershell:12.3.0-ubuntu-22.04

ENV UTILS_VERSION=3.20
ENV PATH="PATH=${PATH}:~/.local/bin"
RUN echo "PATH=${PATH}:~/.local/bin" >> ~/.bashrc   

COPY ca-certificates.crt /etc/ssl/certs/
COPY sleep.sh /bin/sleep.sh

RUN apt-get update \
  && apt-get install --no-install-recommends --yes \
    lsb-release \
    wget \
    unzip \ 
    bzip2 \
    git \
    curl \
    sudo \
    apt-utils \
    locales \
    dnsutils \
    jq \
    net-tools \
    iputils-ping \
    redis-tools \
    vim \
    iproute2 \
    python3 \
    python3-pip \
    traceroute \
    ca-certificates  \
    nmon \  
    slurm \
    #nmap \
    #netcat \
    htop \
    bpftrace \
    build-essential \
    libelf-dev \
    clang \
    llvm \
    linux-tools-generic-6.8 \
    linux-cloud-tools-generic-6.8 \
    linux-tools-azure-lts-22.04 \
    linux-cloud-tools-azure-lts-22.04 \
    linux-tools-azure-6.8 \
    linux-cloud-tools-azure-6.8 \
    #linux-tools-$(uname -r) \
    #linux-cloud-tools-$(uname -r) \
  && apt-get clean

RUN pip install yq

RUN wget -q https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm -rf packages-microsoft-prod.deb

WORKDIR /code
RUN git clone https://github.com/briandenicola/tooling
RUN git clone https://github.com/briandenicola/psscripts
RUN git clone --recurse-submodules https://github.com/libbpf/bpftool.git

RUN bash tooling/istio.sh
RUN bash tooling/flux2.sh 0.41.2 #4/21/23 - issues with flux2.0rc release
RUN bash tooling/terraform.sh
RUN bash tooling/hey.sh
RUN bash tooling/helm.sh
RUN bash tooling/ngrok.sh
RUN bash tooling/grpcurl.sh
RUN bash tooling/kubelogin.sh
RUN bash tooling/k9s.sh
RUN bash tooling/azcopy.sh
RUN bash tooling/azure-cli.sh
RUN bash tooling/task.sh
RUN bash tooling/sqlcmd.sh
RUN bash tooling/skaffold.sh
#RUN bash tooling/vault.sh
#RUN bash tooling/sysinternals.sh

RUN chmod a+x /bin/sleep.sh 
ENTRYPOINT ["/bin/sleep.sh"]