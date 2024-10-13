#!/bin/bash

# Оновлюємо систему
sudo apt update && sudo apt upgrade -y

# Підключення загальних функцій та змінних з репозиторію
source <(curl -s https://raw.githubusercontent.com/R1M-NODES/utils/master/common.sh)

# Відображення логотипу
printLogo

# Встановлення Docker та Docker Compose
printGreen "Install Docker and Docker Compose"
bash <(curl -s https://raw.githubusercontent.com/R1M-NODES/utils/master/docker-install.sh)

# Оновлюємо систему
sudo apt update

# Клонуємо репозиторій Unichain
git clone https://github.com/Uniswap/unichain-node

# Переходимо в директорію unichain-node
cd unichain-node

# Змінюємо RPC у конфігурації .env.sepolia
sed -i 's|^OP_NODE_L1_ETH_RPC=.*|OP_NODE_L1_ETH_RPC=https://ethereum-sepolia-rpc.publicnode.com|' .env.sepolia
sed -i 's|^OP_NODE_L1_BEACON=.*|OP_NODE_L1_BEACON=https://ethereum-sepolia-beacon-api.publicnode.com|' .env.sepolia

# Запускаємо ноду
docker-compose up -d

# Чекаємо кілька секунд, щоб нода запустилася
sleep 10

# Перевіряємо роботу ноди за допомогою curl
curl -d '{"id":1,"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest",false]}' \
  -H "Content-Type: application/json" http://localhost:8545

# Перевіряємо логи unichain-node-op-node-1
docker logs unichain-node-op-node-1

echo "Встановлення завершено. Перевірте конфігурацію та логи для подальшої інформації."
