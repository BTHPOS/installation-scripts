# install dependencies
sudo apt update -y
sudo apt upgrade -y
sudo apt install build-essential libtool autotools-dev automake pkg-config bsdmainutils curl git -y
sudo apt install nsis -y

# Lib boost
sudo apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev -y

# open ssl
sudo apt-get install libssl-dev -y

# libevent
sudo apt-get install libevent-dev -y

# cURL and LibTools
sudo apt-get install curl git build-essential libtool autotools-dev -y

# Setup python3 other utils
sudo apt-get install automake pkg-config bsdmainutils python3 -y

# Libx11
sudo apt-get install libx11-xcb-dev libfontconfig-dev -y

# Set the default mingw32 g++ compiler option to posix.
sudo apt install g++-mingw-w64-x86-64 -y
sudo update-alternatives --config x86_64-w64-mingw32-g++ 

# Install BerkelyDB
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update -y
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y

# Clone BTH
cd /$1
git clone https://github.com/BTHPOS/BTH.git BTH
cd BTH

# Configure paths
PATH=$(echo "$PATH" | sed -e 's/:\/mnt.*//g')


# Prepare for build
cd depends
make HOST=x86_64-w64-mingw32


# Create the build
cd ..
./autogen.sh
CONFIG_SITE=$PWD/depends/x86_64-w64-mingw32/share/config.site ./configure --prefix=/
make -j
make deploy
