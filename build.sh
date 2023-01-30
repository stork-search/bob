#!/bin/sh
# shellcheck shell=dash

cargo -V || curl https://sh.rustup.rs -sSf | sh -s -- -vy

curl https://github.com/jameslittle230/stork/archive/refs/heads/master.zip -o stork-master.zip
unzip stork-master.zip

cd stork-master

git checkout v1.6.0

cargo install just

just build-indexer

cp ./target/release/stork ..