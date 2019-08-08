### MACHINE SHOULD HAVE 8GB at least. 4GB with 4GB swap file should work as well.

# Install Python3.6 and pip3 if we don't have it already 
sudo apt-get update && sudo apt-get install python3.6 python3.6-dev python3-pip -y 
python3.6 -m pip install --upgrade pip setuptools wheel
python3.6 -m pip install --upgrade aiohttp pylru leveldb plyvel aiorpcx ecdsa

# Install LevelDB
sudo apt-get install python3-leveldb libleveldb-dev -y

# Setup Database dictory 
cd ~
rm -rf electrumxdb
mkdir electrumxdb

# Install ElectrumX
cd ~
sudo rm -rf electrumx
git clone https://github.com/BTHPOS/electrumx.git
cd electrumx
sudo python3.6 setup.py install

# Copy ElectrumX to the correct locations
sudo rm -rf /usr/local/bin/electrumx_server
sudo rm -rf /usr/local/bin/electrumx_rpc
sudo cp electrumx_server /usr/local/bin/
sudo cp electrumx_rpc /usr/local/bin/

# ElectrumX Configuration 
cat <<EOT >> ~/electrumx.conf
# default /etc/electrumx.conf for systemd
  
# Coin
COIN = Bithereum

# REQUIRE
DB_DIRECTORY = /home/ubuntu/electrumxdb

# Network 
NET = mainnet

# Bitcoin Node RPC Credentials
DAEMON_URL = http://bithereum:bithereum@node2.bithereum.network:18554/

# TCP Listening port
TCP_PORT=50001
HOST=0.0.0.0

SSL_PORT=50002
SSL_KEYFILE=/home/ubuntu/electrumxssl/server.key
SSL_CERTFILE=/home/ubuntu/electrumxssl/server.crt

# See http://electrumx.readthedocs.io/en/latest/environment.html for
# information about other configuration settings you probably want to consider.
EOT

# Move to configuration
sudo rm -rf /etc/electrumx.conf
sudo mv ~/electrumx.conf /etc/

# Create ElectrumX Service
cat <<EOT >> ~/electrumx.service
[Unit]
Description=Electrumx
After=network.target

[Service]
EnvironmentFile=/etc/electrumx.conf
ExecStart=/usr/local/bin/electrumx_server
User=ubuntu
LimitNOFILE=8192
TimeoutStopSec=30min

[Install]
WantedBy=multi-user.target
EOT

# Move to services
sudo rm -rf /etc/systemd/system/electrumx.service
sudo mv ~/electrumx.service /etc/systemd/system/

# Increase Swap size 
sudo fallocate -l 4G /swapfile 
sudo chmod 600 /swapfile 
sudo mkswap /swapfile 
sudo swapon /swapfile

# Update Open File Limit 
#   sudo vim /etc/security/limits.conf
#         *    soft    nofile          10000
#         *    hard    nofile          10000
#
#
# Setup SSL certificates for ElectrumX
#
#   cd ~
#   mkdir electrumxssl
#   cd electrumxssl
#   openssl genrsa -out server.key 2048
#   openssl req -new -key server.key -out server.csr
#   openssl x509 -req -days 1825 -in server.csr -signkey server.key -out server.crt
#
# Reloading existing electrumx
# 
#  sudo systemctl daemon-reload
#
