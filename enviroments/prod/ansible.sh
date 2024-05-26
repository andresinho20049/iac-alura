#!/bin/bash
cd /home/ubuntu
sudo apt update -y
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y

# Download playbook on repo
curl https://raw.githubusercontent.com/andresinho20049/iac-alura/escalability/enviroments/prod/playbook.yml -o playbook.yml

ansible-playbook playbook.yml 