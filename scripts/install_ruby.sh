#!/bin/bash

echo Installing ruby...

sudo apt-get install -qy software-properties-common
sudo apt-add-repository -y ppa:brightbox/ruby-ng
sudo apt-get update
sudo apt-get install -qy ruby2.1
