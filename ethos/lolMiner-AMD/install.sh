#########################################
## Installing lolMiner on EthOS- EthOS ##
#########################################

#
# MUST HAVE EthOS 1.3.3 or higher  in order to run
# lolMiner natively in EthOS (i.e. being able to modify the Parameters
# within local.conf)
#
lolminerbuild=lolMiner_v05_Lin64.tar.gz

# Stop any current mining
minestop

# Download lolMiner
git clone https://github.com/BTHPOS/mining-amd-lolminer.git

# Remove the files that we don't need
mkdir lolminer
tar -xvzf mining-amd-lolminer/builds/$lolminerbuild -C lolminer
rm -rf lolminer/user_config.json
rm -rf lolminer/run_miner_with_restart.sh
rm -rf lolminer/run_miner.sh.sh
rm -rf lolminer/run_benchmark.sh.sh
rm -rf mining-amd-lolminer

if [ ! -d "/opt/miners/lolminer" ]; then
  echo "lolminer already exists. Backing up and replacing"
  sudo mv /opt/miners/lolminer /opt/miners/lolminer.BAK
fi

# Move the lolMiner build to where the rest of the miners are
sudo mv lolminer /opt/miners/
