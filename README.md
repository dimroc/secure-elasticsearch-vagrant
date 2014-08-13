## About

Vagrantfile that leverages docker to spin up ElasticSearch that's protected by an nginx proxy with basic_auth.

## Steps

1. Run htpasswd to generate htpassword file: `htpasswd -c elasticsearch.htpasswd elasticsearch`
2. Run `vagrant up`
