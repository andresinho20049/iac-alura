#!/bin/bash
cd /home/ubuntu
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py
sudo python3 -m pip install ansible

# Download playbook on repo
curl https://raw.githubusercontent.com/andresinho20049/iac-alura/escalability/enviroments/prod/playbook.yml -o playbook.yml

ansible-playbook playbook.yml 