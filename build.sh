#!/bin/sh

set -eou pipefail

rm -f stork.zip
rm -rf unzip-dir

cargo -V || curl https://sh.rustup.rs -sSf | sh -s -- -vy
just --version || cargo install just

LOCATION=$(curl -s https://api.github.com/repos/jameslittle230/stork/releases/latest \
| grep "tag_name" \
| awk '{print "https://github.com/jameslittle230/stork/archive/" substr($2, 2, length($2)-3) ".zip"}') \
; curl -L -o stork.zip $LOCATION

unzip stork.zip -d unzip-dir
cd unzip-dir
cd $(ls)

pwd
just build-indexer

cp ./target/release/stork ../..

cd ../../
rm -rf unzip-dir
rm -f stork.zip

ls