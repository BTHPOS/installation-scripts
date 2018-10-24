#########################################
## Installing lolMiner on EthOS- EthOS ##
#########################################

#
# MUST HAVE EthOS 1.3.3 or higher  
#
$build=lolMiner_v05_Lin64.tar.gz

# Stop any current mining
minestop

# Download lolMiner
git clone https://github.com/BTHPOS/mining-amd-lolminer.git

# Remove the files that we don't need
mkdir lolMiner
tar -xvzf mining-amd-lolminer/builds/$build -C lolMiner
rm -rf lolMiner/user_config.json
rm -rf lolMiner/run_miner_with_restart.sh
rm -rf lolMiner/run_miner.sh.sh
rm -rf lolMiner/run_benchmark.sh.sh
rm -rf mining-amd-lolminer

if [ ! -d "/opt/miners/lolMiner" ]; then
  mv /opt/miners/lolMiner /opt/miners/lolMiner.BAK
fi

# Move the lolMiner build to where the rest of the miners are
sudo mv lolMiner /opt/miners/
