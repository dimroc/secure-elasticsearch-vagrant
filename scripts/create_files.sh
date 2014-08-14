# vi: set ft=bash :

echo 'Creating nginx and ES files...'

# nginx
sudo mkdir -p /var/log/nginx
sudo mkdir -p /etc/nginx/sites-enabled
sudo mkdir -p /etc/nginx/conf.d

sudo cp /vagrant/nginx/elasticsearch.htpasswd /etc/nginx/conf.d/elasticsearch.htpasswd
sudo cp /vagrant/nginx/elasticsearch.nginx.conf /etc/nginx/sites-enabled/elasticsearch

# elasticsearch
sudo mkdir -p /data/data
sudo mkdir -p /data/log
sudo mkdir -p /data/plugins
sudo mkdir -p /data/work

sudo cp -R /vagrant/elasticsearch/data /
