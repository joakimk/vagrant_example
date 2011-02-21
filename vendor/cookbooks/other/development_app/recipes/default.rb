#
# Cookbook Name:: development_app
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

include_recipe "passenger_enterprise"

template "#{node[:apache][:dir]}/sites-available/#{node[:development_app][:name]}" do
  source "rails_app.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :root_dir => node[:development_app][:path],
    :server_name => node[:development_app][:server_name]
  )
  if File.exists?("#{node[:apache][:dir]}/sites-enabled/#{node[:development_app][:name]}")
    notifies :reload, resources(:service => "apache2"), :delayed
  end
  not_if { File.exists?("#{node[:apache][:dir]}/sites-enabled/#{node[:development_app][:name]}") }
end

apache_site node[:development_app][:name]

