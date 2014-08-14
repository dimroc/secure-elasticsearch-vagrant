## About

Vagrantfile that leverages docker to spin up ElasticSearch that's protected by an nginx proxy with basic_auth.

## Steps

1. Run htpasswd to generate nginx/htpassword file: `htpasswd -c nginx/elasticsearch.htpasswd elasticsearch`
2. Run `vagrant up`
  - There is support for both the vbox and aws providers.
