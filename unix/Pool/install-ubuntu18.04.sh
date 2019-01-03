# Update system
sudo apt-get update

# Install NPM and node
sudo apt-get install npm -y
sudo npm install n -g -y
sudo n v7

# Update system
sudo apt update

# Install Redis
sudo apt install redis-server -y

# Get pool code and set it up
cd /$1
git clone https://github.com/BTHPOS/pool-z-nomp.git pool
npm update
npm install
