#!/bin/bash

# Run the following to start the script
# mkdir -p ~/.ssh && scp -P 89 dev@198.61.168.192:/home/dev/deploy_keys/id* ~/.ssh
# chmod 400 ~/.ssh/id_rsa
# git clone git@git.tasawr.com:ashraf/moteel-setup.git
# sudo ./setup_base.sh

if ! test -f "chef-solo"; then
    echo "Installing required libraries ..." &&
    sudo apt-get update &&
    sudo apt-get -y install aptitude git unzip wget &&
    sudo aptitude install make
    \curl -L https://get.rvm.io | bash -s stable --ruby=1.9.3 --gems=chef
fi &&

cd cookbooks &&

if [ ! -d "mysql" ]; then
    wget https://github.com/opscode-cookbooks/mysql/archive/master.zip &&
    unzip master.zip && rm -rf master.zip && mv mysql-master mysql
fi &&

if [ ! -d "openssl" ]; then
    wget https://github.com/opscode-cookbooks/openssl/archive/master.zip &&
    unzip master.zip && rm -rf master.zip && mv openssl-master openssl
fi &&

if [ ! -d "build-essential" ]; then
    wget https://github.com/opscode-cookbooks/build-essential/archive/master.zip &&
    unzip master.zip && rm -rf master.zip && mv build-essential-master build-essential
fi &&

if [ ! -d "runit" ]; then
    wget https://github.com/opscode-cookbooks/runit/archive/master.zip &&
    unzip master.zip && rm -rf master.zip && mv runit-master runit
fi &&    

if [ ! -d "ohai" ]; then
    wget https://github.com/opscode-cookbooks/ohai/archive/master.zip &&
    unzip master.zip && rm -rf master.zip && mv ohai-master ohai
fi &&
sudo rm -rf /etc/chef/ohai_plugins/README &&

if [ ! -d "apt" ]; then
    wget https://github.com/opscode-cookbooks/apt/archive/master.zip &&
    unzip master.zip && rm -rf master.zip && mv apt-master apt
fi &&

if [ ! -d "yum" ]; then
    wget https://github.com/opscode-cookbooks/yum/archive/master.zip &&
    unzip master.zip && rm -rf master.zip && mv yum-master yum
fi &&

if [ ! -d "mongodb" ]; then
    wget https://github.com/edelight/chef-mongodb/archive/master.zip &&
    unzip master.zip && rm -rf master.zip && mv chef-mongodb-master mongodb
fi && 

if [ ! -d "python" ]; then
    git clone https://github.com/opscode-cookbooks/python.git
fi &&

if [ ! -d "postgresql" ]; then
    git clone https://github.com/opscode-cookbooks/postgresql.git
fi &&

cd ../

sudo chef-solo -c run_recipies.rb -j machine.json