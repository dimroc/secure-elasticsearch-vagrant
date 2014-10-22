vagrant ssh -c 'docker stop $(docker ps -a -q); docker rm $(docker ps -a -q)'
vagrant ssh -c 'docker run -d --name es -p 127.0.0.1:9200:9200 -p 127.0.0.1:9300:9300 -v /mnt/data:/data dockerfile/elasticsearch /elasticsearch/bin/elasticsearch -Des.config=/data/elasticsearch.yml'
vagrant ssh -c 'docker run -d --name nginx --link es:es -p 80:80 -p 443:443 -v /etc/nginx/conf.d:/etc/nginx/conf.d -v /etc/nginx/sites-enabled:/etc/nginx/sites-enabled -v /var/log/nginx:/var/log/nginx dockerfile/nginx'
