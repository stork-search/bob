#!/bin/sh

rm -f stork.zip
rm -rf unzip-dir

cargo -V || curl https://sh.rustup.rs -sSf | sh -s -- -vy
source "$HOME/.cargo/env"

which apt && sudo apt install build-essential zip unzip libssl-dev pkg-config -y
which yum && sudo yum install gcc zip unzip openssl-devel -y

just --version || cargo install just

LOCATION=$(curl -s https://api.github.com/repos/jameslittle230/stork/releases/latest \
| grep "tag_name" \
| awk '{print "https://github.com/jameslittle230/stork/archive/" substr($2, 2, length($2)-3) ".zip"}') \
; curl -L -o stork.zip "$LOCATION"

unzip stork.zip -d unzip-dir
cd unzip-dir || exit
cd "$(ls)" || exit

pwd
just build-indexer

cp ./target/release/stork ../..

cd ../../
rm -rf unzip-dir
rm -f stork.zip

ls
echo "Success"
echo "Run the following command on your local machine:"
echo "scp -i <keyfile>" $(whoami)"@"$(curl -s icanhazip.com)":"$(pwd)"/stork ."