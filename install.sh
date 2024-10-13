#!/bin/bash

source <(curl -s https://raw.githubusercontent.com/R1M-NODES/utils/master/common.sh)

printLogo

if ! command -v docker &> /dev/null; then
printGreen "Install docker and docker compose"
bash <(curl -s https://raw.githubusercontent.com/R1M-NODES/utils/master/docker-install.sh)
else
    printGreen "Docker is already installed. Skipping installation."
fi

git clone https://github.com/Uniswap/unichain-node

cd unichain-node

# Змінюємо RPC у конфігурації .env.sepolia
sed -i 's|^OP_NODE_L1_ETH_RPC=.*|OP_NODE_L1_ETH_RPC=https://ethereum-sepolia-rpc.publicnode.com|' .env.sepolia
sed -i 's|^OP_NODE_L1_BEACON=.*|OP_NODE_L1_BEACON=https://ethereum-sepolia-beacon-api.publicnode.com|' .env.sepolia

docker-compose up -d

sleep 10

curl -d '{"id":1,"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest",false]}' \
  -H "Content-Type: application/json" http://localhost:8545

docker logs unichain-node-op-node-1

echo "Встановлення завершено. Перевірте конфігурацію та логи для подальшої інформації."
