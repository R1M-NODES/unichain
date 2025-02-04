<b> Install Unichain </b>

```
bash <(curl -s https://raw.githubusercontent.com/R1M-NODES/unichain/master/install.sh)
```

Status

```
curl -d '{"id":1,"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest",false]}' \
  -H "Content-Type: application/json" http://localhost:8545
```

Log

```
docker logs unichain-node-execution-client-1
docker logs unichain-node-op-node-1
```

Restart

```
docker-compose down
docker-compose up -d
```
Stop

```
cd unichain-node && docker-compose stop
```

Delete Node

```
cd unichain-node
docker-compose down
sudo rm -r unichain-node
```
