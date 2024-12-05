# Base image
FROM ubuntu:22.04

# Maintainer
LABEL maintainer="dev@crontype.com"

# Atualiza o sistema e instala dependências básicas
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    apache2-utils \    
    python3 \          
    python3-pip \
    curl \             
    wget \
    git \
    fail2ban \         
    nano \
    vim \
    less \
    net-tools \
    iputils-ping \
    hydra \          
    medusa \          
    nmap && \          
    apt-get clean

# Instala SQLMap
RUN pip install sqlmap

# Configuração do diretório de trabalho
WORKDIR /workspace

# Copie o arquivo de senhas para dentro do container
COPY passwords2.txt /workspace/passwords.txt

# Define um ponto de entrada para que o bash seja iniciado diretamente
CMD ["/bin/bash"]
