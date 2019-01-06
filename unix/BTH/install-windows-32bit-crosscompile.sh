# install dependencies
sudo apt update -y
sudo apt upgrade -y
sudo apt install build-essential libtool autotools-dev automake pkg-config bsdmainutils curl git -y
sudo apt install nsis -y

# Set the default mingw32 g++ compiler option to posix.
sudo apt install g++-mingw-w64-i686 mingw-w64-i686-dev -y
#sudo update-alternatives --config i686-w64-mingw32-g++


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

# Install Libsodium
wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
tar -xf LATEST.tar.gz
rm -rf LATEST.tar.gz
cd libsodium-stable/
./configure
make && make check
sudo make install
cd ..
rm -rf libsodium-stable
sudo ln -s /usr/local/lib/libsodium.so.23 /usr/lib/libsodium.so.23

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
make HOST=i686-w64-mingw32


# Create the build
cd ..
./autogen.sh
CONFIG_SITE=$PWD/depends/i686-w64-mingw32/share/config.site ./configure --prefix=/
make -j
make deploy
