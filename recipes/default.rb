#
# Cookbook Name:: roshi
# Recipe:: default
#
# Copyright 2016, Rob Borek
#
# All rights reserved - Do Not Redistribute
#

redisio_install "redis-installation" do
  version '#{node['redis']['version']'
  download_url 'http://download.redis.io/releases/redis-#{node['redis']['version'].tar.gz'
  install_dir '/usr/local'
end

redisio_configure "redis-install" do
  version '3.2.4'
  default_settings node['redisio']['default_settings']
  servers node['redisio']['servers']
  base_piddir node['redisio']['base_piddir']
  user 'redis'
  group 'redis'
end

tar_extract 'http://repo500px.s3.amazonaws.com/roshi/roshi-#{node['roshi']['version']}.tar.gz' do
  target_dir '/usr/local/bin'
end

package 'nginx' do
  action :install
end

cookbook_file '/etc/init/nginx.conf' do
  source 'nginx.upstart.conf'
  mode '0644'
end

cookbook_file '/etc/nginx/nginx.conf' do
  source 'nginx.conf'
  mode '0644'
end

cookbook_file '/etc/init/roshi.conf' do
  source 'roshi.upstart.conf'
  mode '0644'
end

file '/etc/init.d/nginx' do
  action :delete
end

service 'redismaster' do
  action [:enable, :start]
end

service 'roshi' do
  action [:enable, :start]
end

service 'nginx' do
  action [:enable, :start]
end



