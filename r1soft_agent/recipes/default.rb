
if platform?("ubuntu")
  package "linux-headers-#{node[:kernel][:release]}"
end

remote_file "/root/r1soft-agent.run" do
  arch = node[:kernel][:machine].scan(/x86_([1-9]{2})/).first.first
  source  "http://download.r1soft.com/d/linux-agent/#{node[:r1soft_agent][:version]}-#{node[:kernel][:machine]}/linux-agent-#{arch}-#{node[:r1soft_agent][:version]}-#{node[:platform]}.run"
  mode    "0755"
end

execute "install r1soft agent" do
  user    "root"
  cwd     "/root"
  command "sh r1soft-agent.run -- --yes"
  creates "/etc/buagent/agent_config"  
  action  :run
end

template "/etc/buagent/server.allow/#{node[:r1soft_agent][:server_ip]}" do
  mode    "0644"
  owner   "root"
  group   "root"
  source  "allowed_servers.erb"
  backup  false
end
