# Base Python (3.12)
FROM python:3.12-slim as python-base

# Base Debian do Dev Containers
FROM mcr.microsoft.com/vscode/devcontainers/base:debian

# Usuário root para instalação de dependências
USER root

# Copia o ambiente Python do primeiro estágio
COPY --from=python-base /usr/local /usr/local

# Atualiza e instala pacotes essenciais
RUN apt-get update -y && apt-get install -y \
    zsh python3-dev libpython3-dev build-essential vim curl git sudo pkg-config \
    --no-install-recommends && \
    apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Configura sudo para o usuário vscode
RUN echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Define o shell padrão para zsh
ENV SHELL=/usr/bin/zsh
ENV HOME=/home/vscode

# Define o shell do Dockerfile como ZSH
SHELL ["/usr/bin/zsh", "-o", "pipefail", "-c"]

# Instalação do Rust (adiciona ao PATH corretamente)
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Copia a ferramenta UV para o container
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Instalação do Foundry
RUN curl -L https://foundry.paradigm.xyz | zsh
RUN foundryup

# Instalação do Aderyn (Cyfrin)
RUN curl -L https://raw.githubusercontent.com/Cyfrin/aderyn/dev/cyfrinup/install | zsh
RUN cyfrinup

# Instalação do nvm para Node.js
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Garantir que o usuário 'vscode' tenha permissão sobre os diretórios do nvm e do .npm
#RUN chown -R vscode:vscode /home/vscode
RUN chown -R vscode:vscode /home/vscode/.nvm

# Garantir que o nvm e suas variáveis de ambiente sejam carregadas corretamente
USER vscode
RUN echo 'export NVM_DIR="/home/vscode/.nvm"' >> ~/.zshrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc

# Configuração final
USER root
RUN sudo apt-get autoremove -y && sudo apt-get clean -y

# Muda de volta para o usuário 'vscode'
USER vscode