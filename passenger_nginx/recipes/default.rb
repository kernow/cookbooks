#
# Cookbook Name:: passenger_nginx
# Recipe:: default
#
# Author:: Jamie Dyer (<jamie@kernowsoul.com>)
# 
# Copywrightly:: 2009, Shutup
# 
# License, use this recipe or I will send over tiny
# killer bunnys to stalk you

include_recipe "packages"
include_recipe "ruby"

%w{ make g++ zlib1g-dev libssl-dev }.each do |pkg|
  package pkg
end

gem_package "passenger" do
  version node[:passenger][:version]
end

execute "passenger_module" do
  command "#{node[:passenger][:root_path]}/bin/passenger-install-nginx-module --auto --auto-download --prefix=/opt/nginx"
  not_if { FileTest.exists?("/opt/nginx") }
end

remote_file "/etc/init.d/nginx" do
  source "nginx_initd"
  owner "root"
  group "root"
  mode 0755
end

service "nginx" do
  supports :restart => true, :reload => true
  action [:enable, :start]
end

