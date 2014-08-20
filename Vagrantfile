# vi: set ft=ruby :

def cache config, name, path
  require 'fileutils'
  require 'pathname'
  name = name.to_s
  local = File.join(File.expand_path('~/.vagrant.d/cache'), config.vm.box, name)
  FileUtils.mkdir_p local
  config.vm.synced_folder local, path
end

api_version = '2'

Vagrant.configure(api_version) do |config|
  config.vm.define('glusterone') do |app|
    app.vm.box = 'trusty'
    app.vm.box_url = 'http://boxes.cirrusmio.com/ubuntu/' +
                     'cirrusmio-ubuntu-14.04_virtualbox-1398181987.box'

    app.vm.provider 'virtualbox' do |v|
      v.memory = 512
      v.name = 'glusterone'
    end

    app.vm.network :private_network, ip: '10.1.1.11'

    cache app, :apt, '/var/cache/apt/archives'
    cache app, :chef, '/var/chef/cache'

    app.ssh.forward_agent = true
    app.ssh.username = 'ubuntu'

    app.vm.provision :chef_solo do |chef|
      chef.log_level = :debug
      chef.run_list = ['glustertest', 'glustertest::replica']
    end
  end

  config.vm.define('glustertwo') do |app|
    app.vm.box = 'trusty'
    app.vm.box_url = 'http://boxes.cirrusmio.com/ubuntu/' +
                     'cirrusmio-ubuntu-14.04_virtualbox-1398181987.box'

    app.vm.provider 'virtualbox' do |v|
      v.memory = 512
      v.name = 'glustertwo'
    end

    cache app, :apt, '/var/cache/apt/archives'
    cache app, :chef, '/var/chef/cache'

    app.vm.network :private_network, ip: '10.1.1.12'

    app.ssh.forward_agent = true
    app.ssh.username = 'ubuntu'

    app.vm.provision :chef_solo do |chef|
      chef.log_level = :debug
      chef.run_list = ['glustertest', 'glustertest::replica_primary']
    end
  end

  config.vm.define('glusterthree') do |app|
    app.vm.box = 'trusty'
    app.vm.box_url = 'http://boxes.cirrusmio.com/ubuntu/' +
                     'cirrusmio-ubuntu-14.04_virtualbox-1398181987.box'

    app.vm.provider 'virtualbox' do |v|
      v.memory = 512
      v.name = 'glusterthree'
    end

    cache app, :apt, '/var/cache/apt/archives'
    cache app, :chef, '/var/chef/cache'

    app.vm.network :private_network, ip: '10.1.1.13'

    app.ssh.forward_agent = true
    app.ssh.username = 'ubuntu'

    app.vm.provision :chef_solo do |chef|
      chef.log_level = :debug
      chef.run_list = ['glustertest::replica_sub']
    end
  end
end
