
script "install bfd" do
  interpreter "bash"
  user        "root"
  cwd         "/tmp"
  code <<-EOH
  wget http://www.rfxn.com/downloads/bfd-#{node[:bfd][:version]}.tar.gz
  tar -zxf bfd-#{node[:bfd][:version]}.tar.gz
  cd bfd-#{node[:bfd][:version]}
  sh install.sh
  EOH
  not_if { FileTest.exists?("/usr/local/bfd") }
end

template "/usr/local/bfd/conf.bfd" do
  mode    "0640"
  owner   "root"
  group   "root"
  source  "bfd_config.erb"
end
