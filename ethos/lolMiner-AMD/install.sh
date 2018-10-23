#########################################
## Installing lolMiner on EthOS- EthOS ##
#########################################

# Stop any current mining
minestop

# Download lolMiner
git clone https://github.com/BTHPOS/mining-amd-lolminer.git

# Remove the files that we don't need
mkdir lolMiner
tar -xvzf ~/mining-amd-lolminer/builds/lolMiner_v05_Lin64.tar.gz -C lolMiner
rm -rf lolMiner/user_config.json
rm -rf lolMiner/run_miner_with_restart.sh
rm -rf lolMiner/run_miner.sh.sh
rm -rf lolMiner/run_benchmark.sh.sh
rm -rf mining-amd-lolminer
rm -rf /opt/miners/lolMiner > /dev/null

# Move the lolMiner build to where the rest of the miners are
sudo mv lolMiner /opt/miners/

# Backup the current custom configuration
mv ~/custom.sh ~/custom.sh.disabled

# Move the new config to the home directory
mv ./custom.sh ~/custom.sh
chmod +x ~/custom.sh
