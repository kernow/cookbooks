include_recipe "passenger_nginx"
include_recipe "rails_postgresql"
include_recipe "git"
include_recipe "rails"
include_recipe "vlad"

gem_package "rake"

# Create user
user node[:nginx_app][:user] do
  home "/home/#{node[:nginx_app][:user]}"
  shell "/bin/bash"
  supports :manage_home => true
end

# Setup vlad support
vlad_setup node[:nginx_app][:name] do
  path  node[:nginx_app][:path]
  owner node[:nginx_app][:user]
  group node[:nginx_app][:group]
end

# Setup authorized SSH keys
ssh_authorized_keys "vlad users" do
  user node[:nginx_app][:user]
  keys node[:nginx_app][:ssh_keys]
end

# Add github.com to the known hosts file
ssh_known_hosts "Adding github" do
  user node[:nginx_app][:user]
  hosts ["github.com"]
end

postgresql_new_user     node[:nginx_app][:user]
postgresql_new_database node[:nginx_app][:user]