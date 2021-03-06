# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

def run_docker(config)
  config.vm.provision "docker", images: ["dockerfile/nginx", "dockerfile/elasticsearch"] do |d|
    d.run "dockerfile/elasticsearch",
      daemonize: true,
      cmd: "/elasticsearch/bin/elasticsearch -Des.config=/data/elasticsearch.yml",
      args: "--name es -p 127.0.0.1:9200:9200 -p 127.0.0.1:9300:9300 -v /mnt/data:/data"

    d.run "dockerfile/nginx",
      daemonize: true,
      args: "--name nginx --link es:es -p 80:80 -p 443:443 -v /etc/nginx/conf.d:/etc/nginx/conf.d -v /etc/nginx/sites-enabled:/etc/nginx/sites-enabled -v /var/log/nginx:/var/log/nginx"
  end
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider :virtualbox do |vbox, override|
    override.vm.box = "dimroc/ubuntu14.04"
    override.vm.network "forwarded_port", guest: 80, host: 8888
    override.vm.provision "shell", path: 'scripts/create_files.sh'
    run_docker(override)
  end

  config.vm.provider :aws do |aws, override|
    override.vm.box = "dimroc/awsdummy"
    override.ssh.username = "ubuntu"
    override.vm.provision "shell", path: 'scripts/mount_instance_store.sh'
    override.vm.provision "shell", path: 'scripts/create_files.sh'
    run_docker(override)

    aws.access_key_id = ENV["AWS_ACCESS_KEY_ID"]
    aws.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]

    # AWS Keypair name and private key path. Required to SSH into created instance.
    aws.keypair_name = 'loopandtie-qa'
    override.ssh.private_key_path = "~/.ssh/loopandtie-qa.pem"

    aws.ami = "ami-98aa1cf0"
    aws.instance_type = "m1.small"
    aws.block_device_mapping = [
      { 'DeviceName' => '/dev/sda1', 'Ebs.VolumeSize' => 20, 'Ebs.VolumeType' => 'gp2' },
      { 'DeviceName' => '/dev/sdb', 'VirtualName' => 'ephemeral0' }
    ]

    aws.elastic_ip = true
    aws.tags = { "Name" => "NGINX Basic Auth + ES" }
  end

  config.vm.provision "shell", inline: 'sudo apt-get update'
  config.vm.provision "shell", path: 'scripts/install_cli_helpers.sh'
  config.vm.provision "shell", path: 'scripts/install_ruby.sh'

  config.vm.define "nginx_elasticsearch"
end

