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
  config.vm.box = 'trusty'
  config.vm.box_url = 'http://boxes.cirrusmio.com/ubuntu/' +
                      'cirrusmio-ubuntu-14.04_virtualbox-1398181987.box'

  config.vm.provider 'virtualbox' do |v|
    v.memory = 512
  end

  cache config, :apt, '/var/cache/apt/archives'
  cache config, :chef, '/var/chef/cache'

  config.ssh.forward_agent = true
  config.ssh.username = 'ubuntu'

  # distribute-only (with volume creation)
  config.vm.define('glusterfour') do |app|
    app.vm.network :private_network, ip: '10.1.1.14'
    config.vm.provider('virtualbox') {|v| v.name = 'glusterfour' }
    app.vm.provision :chef_solo do |chef|
      chef.run_list = ['glustertest::distribute']
    end
  end

  # replica 1
  config.vm.define('glusterthree') do |app|
    app.vm.network :private_network, ip: '10.1.1.13'
    config.vm.provider('virtualbox') {|v| v.name = 'glusterthree' }
    app.vm.provision :chef_solo do |chef|
      chef.run_list = ['glustertest::replica']
    end
  end

  # replica 2 & volume creation
  config.vm.define('glustertwo') do |app|
    app.vm.network :private_network, ip: '10.1.1.12'
    config.vm.provider('virtualbox') {|v| v.name = 'glustertwo' }
    app.vm.provision :chef_solo do |chef|
      chef.run_list = ['glustertest::replica_primary']
    end
  end

  # mount drives from distribute and replica
  config.vm.define('gluster') do |app|
    app.vm.network :private_network, ip: '10.1.1.11'
    config.vm.provider('virtualbox') {|v| v.name = 'gluster' }
    app.vm.provision :chef_solo do |chef|
      chef.run_list = ['glustertest::replica_mount',
                       'glustertest::distribute_mount']
    end
  end

end
