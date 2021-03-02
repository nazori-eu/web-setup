#!/bin/bash

sudo apt purge certbot python3-certbot-nginx
sudo apt purge nginx nginx-common
sudo apt purge ufw

sudo apt autoremove
