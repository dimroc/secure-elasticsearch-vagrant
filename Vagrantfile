# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider :virtualbox do |vbox, override|
    override.vm.box = "dimroc/ubuntu14.04"
  end

  config.vm.provider :aws do |aws, override|
    override.vm.box = "dimroc/awsdummy"
    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "~/.ssh/dimitrib.qa.pem"

    aws.access_key_id = ENV["AWS_ACCESS_KEY_ID"]
    aws.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
    aws.keypair_name = 'dimitrib'

    aws.ami = "ami-864d84ee"
    aws.instance_type = "i2.xlarge"

    aws.elastic_ip = true
    aws.associate_public_ip = true
    aws.subnet_id = "subnet-0901194f"
    aws.tags = { "Name" => "NGINX Basic Auth + ES" }
  end

  config.vm.provision "shell", inline: 'sudo apt-get update'
  config.vm.provision "shell", path: 'install_cli_helpers.sh'
  config.vm.provision "shell", path: 'install_ruby.sh'
  config.vm.provision "shell", path: 'create_files.sh'

  config.vm.provision "docker", images: ["dockerfile/nginx", "dockerfile/elasticsearch"] do |d|
    # docker run -d -p 127.0.0.1:9200:9200 -p 127.0.0.1:9300:9300 dockerfile/elasticsearch # only allows localhost connections w 127.0.0.1
    d.run "dockerfile/elasticsearch", daemonize: true, args: "--name es -p 127.0.0.1:9200:9200 -p 127.0.0.1:9300:9300"

    # docker run -d -p 80:80 dockerfile/nginx
    d.run "dockerfile/nginx", daemonize: true, args: "--name nginx --link es:es -p 80:80 -v /etc/nginx/sites-enabled:/etc/nginx/sites-enabled -v /var/log/nginx:/var/log/nginx"
  end

  config.vm.define "nginx_elasticsearch"
end
