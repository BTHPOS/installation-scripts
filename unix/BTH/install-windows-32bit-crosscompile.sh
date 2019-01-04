# install dependencies
sudo apt update -y
sudo apt upgrade -y
sudo apt install build-essential libtool autotools-dev automake pkg-config bsdmainutils curl git -y
sudo apt install nsis -y

# Set the default mingw32 g++ compiler option to posix.
sudo update-alternatives --config i686-w64-mingw32-g++  -y


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
make
make deploy
