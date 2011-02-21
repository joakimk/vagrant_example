#
# Cookbook Name:: development
# Recipe:: default
#
# Copyright 2010, Joakim Kolsjö
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

bash "Prepare development environment" do
  ruby_enterprise_install_path = node[:ruby_enterprise][:install_path]
  app_path = node[:development_app][:path]
  profile_path = "/home/vagrant/.profile"
  ssh_config_path = "/home/vagrant/.ssh/config"

  code <<-EOH
    # Short, custom hostname
    echo 'box' > /etc/hostname
    echo '127.0.0.1 box' >> /etc/hosts
    service hostname start

    # Adding REE to path
    echo 'export PATH=\"#{ruby_enterprise_install_path}/bin:$PATH\"' >> #{profile_path}

    # Setting timezone
    echo 'export TZ="Europe/Stockholm"' >> #{profile_path}

    # Auto cd to app path
    echo 'cd #{app_path}' >> #{profile_path}
    
    # If you want to use git within the VM:
    # su vagrant -c 'ln -s /user/.ssh/id_rsa /home/vagrant/.ssh/id_rsa'
    # su vagrant -c 'ln -s /user/.ssh/id_rsa.pub /home/vagrant/.ssh/id_rsa.pub'
    # su vagrant -c 'ln -s /user/.ssh/config /home/vagrant/.ssh/config'
    # su vagrant -c 'ln -s /user/.ssh/known_hosts /home/vagrant/.ssh/known_hosts'
    # su vagrant -c 'ln -s /user/.gitconfig /home/vagrant/.gitconfig'

    chown -R vagrant /home/vagrant/.gem
    su vagrant -c 'source #{profile_path}; cd #{app_path}; bundle; rake db:migrate'
  EOH
  
  not_if do
    ::File.read("/etc/hostname").include?("box")
  end
end

