FROM mcr.microsoft.com/azure-powershell:9.6.0-ubuntu-22.04

RUN apt-get update \
  && apt-get install --no-install-recommends --yes \
    lsb-release \
    wget \
    unzip \ 
    git \
    curl \
    sudo \
    apt-utils \
    locales \
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
    slurm \
  && apt-get clean

RUN wget -q https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb

COPY ca-certificates.crt /etc/ssl/certs/
COPY sleep.sh /bin/sleep.sh

RUN rm -rf packages-microsoft-prod.deb

WORKDIR /code
RUN git clone https://github.com/briandenicola/tooling
RUN git clone https://github.com/briandenicola/psscripts

ENV PATH="PATH=${PATH}:~/.local/bin"
RUN echo "PATH=${PATH}:~/.local/bin" >> ~/.bashrc   

RUN bash tooling/istio.sh
RUN bash tooling/flux2.sh
RUN bash tooling/terraform.sh
RUN bash tooling/vault.sh
RUN bash tooling/hey.sh
RUN bash tooling/helm.sh
RUN bash tooling/ngrok.sh
RUN bash tooling/grpcurl.sh
RUN bash tooling/kubelogin.sh
RUN bash tooling/k9s.sh
#RUN bash tooling/sysinternals.sh

RUN chmod a+x /bin/sleep.sh 
ENTRYPOINT ["/bin/sleep.sh"]
