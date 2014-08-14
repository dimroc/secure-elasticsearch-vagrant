# vi: set ft=bash :

# nginx
sudo mkdir -p /var/log/nginx
sudo mkdir -p /etc/nginx/sites-enabled
sudo mkdir -p /etc/nginx/conf.d

sudo cp /vagrant/elasticsearch.htpasswd /etc/nginx/conf.d/elasticsearch.htpasswd
sudo cp /vagrant/elasticsearch.nginx.conf /etc/nginx/sites-enabled/elasticsearch

# elasticsearch
sudo mkdir -p /data/data
sudo mkdir -p /data/log
sudo mkdir -p /data/plugins
sudo mkdir -p /data/work

sudo cp -R /vagrant/data /
