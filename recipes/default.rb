#
# Cookbook Name:: roshi
# Recipe:: default
#
# Copyright 2016, Rob Borek
#
# All rights reserved - Do Not Redistribute
#

node.default['redisio']['job_control'] = 'upstart'

include_recipe 'redisio'

tar_extract 'http://repo.s3.amazonaws.com/roshi/roshi-#{node['roshi']['version']}.tar.gz' do
  target_dir '/usr/local/bin'
  creates '/usr/local/bin/roshi-server'
  notifies :restart, 'service[roshi]'
end

package 'nginx' do
  action :install
end

cookbook_file '/etc/init/nginx.conf' do
  source 'nginx.upstart.conf'
  mode '0644'
  notifies :restart, 'service[nginx]'
end

cookbook_file '/etc/nginx/nginx.conf' do
  source 'nginx.conf'
  mode '0644'
  notifies :restart, 'service[nginx]'
end

cookbook_file '/etc/init/roshi.conf' do
  source 'roshi.upstart.conf'
  mode '0644'
  notifies :restart, 'service[roshi]'
end

include_recipe 'redisio::enable'

service 'roshi' do
  action [:enable, :start]
end

service 'nginx' do
  action [:enable, :start]
end



