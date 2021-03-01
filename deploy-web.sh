#!/bin/bash

echo "Installing Nginx"

sudo apt -y install nginx ufw

echo "Setting up Firewall"

sudo ufw allow 22
sudo ufw allow 'Nginx Full'
echo "y" | sudo ufw enable
sudo ufw reload
sudo ufw status

echo "Setting up Hugo"

wget https://github.com/gohugoio/hugo/releases/download/v0.81.0/hugo_0.81.0_Linux-ARM64.deb
sudo dpkg -i hugo_0.81.0_Linux-ARM64.deb
rm hugo_0.81.0_Linux-ARM64.deb

echo "Clonning Webs"

git clone https://github.com/nazori-eu/nazori_web.git
git clone --recurse-submodules https://github.com/nazori-eu/btapes_site.git


echo "Setting up Nginx"

sudo systemctl start nginx
paste primitive config sites available
sudo mkdir /var/www/btapes-site
sudo chmod 0755 /var/www/btapes-site

