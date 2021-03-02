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

cd /home/nazori/
pwd
git clone --recurse-submodules https://github.com/nazori-eu/nazori-web.git
git clone --recurse-submodules https://github.com/nazori-eu/btapes-site.git

read -p "Press enter to continue"

echo "Setting up Nginx"

sudo systemctl start nginx

sudo cp /home/nazori/web-setup/btapes.conf /etc/nginx/sites-available/
sudo cp /home/nazori/web-setup/nazori.conf /etc/nginx/sites-available/

sudo mkdir /var/www/btapes
sudo mkdir /var/www/nazori

sudo chown nazori /var/www/nazori
sudo chown nazori /var/www/btapes

read -p "Press enter to continue"

sudo ln -s /etc/nginx/sites-available/nazori.conf /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/btapes.conf /etc/nginx/sites-enabled/

cd /home/nazori/btapes-site
./deploy-hugo.sh

cd /home/nazori/nazori-web
./deploy-hugo.sh

sudo systemctl reload nginx

read -p "Press enter to continue"

echo "Installing Cerbot"

sudo apt -y install certbot python3-certbot-nginx
sudo certbot --nginx
sudo systemctl restart nginx
crontab -l | { cat; echo "0 9 * * * certbot renew --post-hook "systemctl reload nginx""; } | crontab -

