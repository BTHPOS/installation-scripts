## Update system
sudo apt-get update

## Install NVM 
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## Install Node version 4 
nvm install v4 

## Dependencies
sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libsodium-dev -y
sudo apt-get install python -y
sudo apt-get install libboost-all-dev -y
sudo apt-get install libzmq3-dev -y

sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y

## Clone Bitcore Node 
git clone https://github.com/BTHPOS/bitcore-node.git
cd bitcore-node
npm i 

## Create Node 
cd ~
./bitcore-node/bin/bitcore-node create bitcore-bithereum

## Install Insight
cd bitcore-bithereum
./node_modules/bitcore-node/bin/bitcore-node install https://github.com/BTHPOS/insight.git
./node_modules/bitcore-node/bin/bitcore-node install https://github.com/BTHPOS/insight-api.git

## Staring Insight 
./node_modules/bitcore-node/bin/bitcore-node start
