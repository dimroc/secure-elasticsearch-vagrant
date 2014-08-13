# vi: set ft=bash :

sudo mkdir -p /var/log/nginx
sudo mkdir -p /etc/nginx/sites-enabled
sudo cp /vagrant/elasticsearch.nginx.conf /etc/nginx/sites-enabled/elasticsearch
