#!/bin/bash
sudo apt update -y
sudo apt install -y apache2
sudo ufw allow 'Apache'
sudo ufw --force enable
echo "Server $(hostname -f) is running!"