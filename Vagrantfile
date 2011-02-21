Vagrant::Config.run do |config|
  config.vm.box = "base"

  # Ubuntu 10.04 (32 bit)
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"

  config.vm.customize do |vm|
    vm.name = "Vagrant example app"
    vm.memory_size = 512
  end

  config.vm.network "10.5.5.5"
  
  # Mounts the app at /app instead of the default /vagrant
  config.vm.share_folder("v-root", "/app", ".")
  
  # NFS is much faster than the default sharing method
  # config.vm.share_folder("v-root", "/app", ".", :nfs => true)
  
  # To share user folder to VM
  # config.vm.share_folder("user", "/user", ENV['HOME'])

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = [ "vendor/cookbooks/opscode",
                            "vendor/cookbooks/other",
                            # Overrides to the above cookbooks
                            "vendor/cookbooks/site" ]
    chef.json = {
      "mysql" => {
        "server_root_password" =>  "",
        "bind_address" => "127.0.0.1"
       },
       "ruby_enterprise" => {
         "version" => "1.8.7-2011.01",
         "url" => "http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise-1.8.7-2011.01"
       },
       "passenger_enterprise" => {
         "version" => "3.0.2"
       },
       "development_app" => {
        "name" => "app",
        "server_name" => "app.dev",
        "path" => "/app"
       }
    }
    
    chef.add_recipe "apt"
    chef.add_recipe "build-essential"
    chef.add_recipe "ruby_enterprise"
    chef.add_recipe "bundler_enterprise"
    chef.add_recipe "passenger_enterprise::apache2"
    chef.add_recipe "mysql::server"
    chef.add_recipe "git"
    chef.add_recipe "development_app"
    chef.add_recipe "development"
  end

end

