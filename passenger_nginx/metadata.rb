maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs passenger for Nginx"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version           "0.11"

%w{ packages ruby rails }.each do |cb|
  depends cb
end

%w{ redhat centos ubuntu debian }.each do |os|
  supports os
end

attribute "passenger/version",
  :display_name => "Passenger Version",
  :description => "Version of Passenger to install",
  :default => "2.2.5"

attribute "passenger/root_path",
  :display_name => "Passenger Root Path",
  :description => "Location of passenger installed gem",
  :default => "gem_dir/gems/passenger-passenger_version"

