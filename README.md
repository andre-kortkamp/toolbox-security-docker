
# 🛡️ Solidity Security Audit Environment
Este é um microserviço Docker customizado para auditorias de smart contracts em Solidity.
Ele provê um ambiente leve, poderoso e pronto para usar, com ferramentas essenciais para desenvolvimento, testes e segurança.

# 📦 O que vem instalado?
Python 3.12 (gerenciamento de scripts e automações)

Rust (necessário para ferramentas de segurança modernas)

Foundry (forge, cast) — suíte de ferramentas para smart contracts

Aderyn (by Cyfrin) — scanner de segurança para Solidity

NVM + Node.js (controle de versões de Node para front-ends/dapps auxiliares)

Zsh como shell padrão

Build Essentials (gcc, make, libs de C/C++)

Git, Vim, Curl, Sudo — utilitários de desenvolvimento

# 🚀 Como usar
Buildar a imagem
```docker build -t solidity-audit-env . ```
Rodar o container
```docker run -it --rm solidity-audit-env```
Você cairá direto num terminal zsh configurado, como o usuário vscode.

# ⚙️ Estrutura do Dockerfile
Multi-stage build: primeiro instala o Python numa imagem separada para otimizar o tamanho final.

Ambiente DevContainer: usa uma base compatível com Visual Studio Code DevContainers, perfeito para desenvolvimento remoto.

Ferramentas de segurança: Foundry e Aderyn instalados via script.

Suporte a Node.js: via nvm, para usar dapps que interajam com smart contracts.

# 🛠️ Ferramentas principais

Foundry	Testes, deploys e fuzzing de contratos Solidity
Aderyn	Scanner de vulnerabilidades para smart contracts
Rust	Requisito para algumas ferramentas de auditoria avançadas
Python	Para scripts de análise, automação e integração
Node.js	Para ambientes de frontend/web3 e integração dapp

# 📋 Notas importantes

O shell padrão é zsh para uma experiência de terminal moderna.

O usuário padrão é vscode (com sudo liberado).

Após iniciar o container, foundryup e cyfrinup já terão rodado — tudo pronto para uso.

O ambiente é ideal para trabalhar diretamente com VSCode usando DevContainers (Remote - Containers).

# 📄 Exemplos de uso dentro do container

# Atualizar Foundry
```foundryup```

# Rodar o Aderyn em um projeto
```aderyn analyze ./src```

# Testar contratos com Forge
```forge test```

# Deployar com Cast
```cast send --private-key <key> --to <address> --value <eth>```

# 🧠 Para que este ambiente é ideal?

Auditar contratos Solidity (forge test, fuzz, coverage)

Escanear vulnerabilidades (aderyn analyze)

Analisar comportamento de transações (cast tools)

Integrar facilmente com scripts Node.js ou Python

Trabalhar de forma segura, isolada e reprodutível

# ✨ Contribuição

Este ambiente é altamente customizável.
Você pode:

Adicionar ferramentas de análise extra como Slither, Mythril ou Echidna.

Adaptar o ambiente para usar Hardhat, Truffle ou Foundry.

Pull requests e sugestões são bem-vindos! 🚀
