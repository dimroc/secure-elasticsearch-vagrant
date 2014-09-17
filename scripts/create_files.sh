# vi: set ft=sh :

echo 'Creating nginx and ES files...'

# nginx
sudo mkdir -p /var/log/nginx
sudo mkdir -p /etc/nginx/sites-enabled
sudo mkdir -p /etc/nginx/conf.d

sudo cp /vagrant/nginx/elasticsearch.htpasswd /etc/nginx/conf.d/elasticsearch.htpasswd
sudo cp /vagrant/nginx/elasticsearch.nginx.conf /etc/nginx/sites-enabled/elasticsearch

# elasticsearch
sudo mkdir -p /mnt/data/data
sudo mkdir -p /mnt/data/log
sudo mkdir -p /mnt/data/plugins
sudo mkdir -p /mnt/data/work

sudo cp -R /vagrant/elasticsearch/data /mnt/
