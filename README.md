## About

Vagrantfile that leverages docker to spin up ElasticSearch that's protected by an nginx proxy with basic_auth.

## Reasons for Vagrant

- Allows one to easily run different versions of Elastic Search on the same dev box because of the isolation provided by VMs.
- Simple and consistent setup across computers and environments.
- Not ready for prod deployment because of the scale required for production (multiple ES nodes). Outside of scope.

## Dependencies

1. [Vagrant](http://www.vagrantup.com/downloads.html) >= 1.6.3
2. Vagrant plugins (any version greater is fine):
  - [vagrant-aws](https://github.com/mitchellh/vagrant-aws) (0.5.0)
    `vagrant plugin install vagrant-aws`
  - vagrant-login (1.0.1, system)
  - vagrant-share (1.1.0, system)

## Steps

1. Run htpasswd to generate a password in the nginx/htpassword file for user `elasticsearch`:

  ```
  htpasswd -c nginx/elasticsearch.htpasswd elasticsearch
  ```

2. Only for AWS. In the `Vagrantfile`, replace the keypair name and private_key_path with your own values:

  ```ruby
      # AWS Keypair name and private key path. Required to SSH into created instance.
      aws.keypair_name = 'your keypair name'
      override.ssh.private_key_path = "~/.ssh/your_private_key.pem"
  ```

3. Run `vagrant up --provider=aws`
  - There is also support for vbox for local development.
    `vagrant up --provider=vbox`

You're done! See below to view your ES server in the browser.

### Vbox Provider

  - Log into Elastic Search Head, the Web UI, with username: elasticsearch and password: generated_password_from_1
    - http://localhost:8888/_plugin/head/
    - Give it a minute after successful creation, nginx takes a minute to do its thing.

### AWS Provider

  - Retrieve the public domain name via AWS console or with the following command:

    ```
    vagrant ssh -c 'echo $(curl -s http://169.254.169.254/latest/meta-data/public-hostname)'
    ```

  - Log into Elastic Search Head, the Web UI, with username: elasticsearch and password: generated_password_from_1
    - http://your_url/_plugin/head/
    - e.g. http://ec2-107-20-174-145.compute-1.amazonaws.com/_plugin/head/

## Clean up

- If you ever need to destroy the instance, aws or vbox, `vagrant destroy` will clean it up.
- **This WILL nuke your data.**
