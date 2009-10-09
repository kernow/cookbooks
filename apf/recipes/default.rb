
include_recipe "iptables"

script "install apf" do
  interpreter "bash"
  user        "root"
  cwd         "/tmp"
  code <<-EOH
  wget http://www.rfxn.com/downloads/apf-9.7-1.tar.gz
  tar -zxf apf-9.7-1.tar.gz
  cd apf-9.7-1
  sh install.sh
  EOH
  not_if { FileTest.exists?("/etc/apf") }
end

execute "restart" do
  command "/usr/local/sbin/apf -r"
  action :nothing
end

template "/etc/apf/conf.apf" do
  mode    "0640"
  owner   "root"
  group   "root"
  source  "apf_config.erb"
  notifies :run, resources(:execute => "restart")
end

template "/etc/apf/allow_hosts.rules" do
  mode    "0640"
  owner   "root"
  group   "root"
  source  "allowed_hosts.erb"
  notifies :run, resources(:execute => "restart")
end
