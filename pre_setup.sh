#!/bin/bash

deployment_user=dev
ip_address=166.78.238.223

ssh -t "$deployment_user"@"$ip_address" 'mkdir ~/.ssh'
scp deploy_keys/id_rsa* "$deployment_user"@"$ip_address:~/.ssh"
ssh -t "$deployment_user"@"$ip_address" 'sudo apt-get update && sudo apt-get -y install git'
ssh -t "$deployment_user"@"$ip_address" 'git clone git@git.tasawr.com:ashraf/moteel-setup.git'