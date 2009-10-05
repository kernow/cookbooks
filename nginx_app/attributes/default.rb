nginx_app Mash.new unless attribute?("nginx_app")

nginx_app[:name] = "website" unless nginx_app.has_key?(:name)
nginx_app[:user] = nginx_app[:name] unless nginx_app.has_key?(:user)
nginx_app[:domain] = fqdn unless nginx_app.has_key?(:domain)
nginx_app[:aliases] = [] unless nginx_app.has_key?(:aliases)
nginx_app[:path] = "/home/#{nginx_app[:user]}/#{nginx_app[:name]}" unless nginx_app.has_key?(:path)
nginx_app[:ssh_keys] = [] unless nginx_app.has_key?(:ssh_keys)

nginx_app[:rails] = {} unless nginx_app.has_key?(:rails)
nginx_app[:rails][:environment]  = "production" unless nginx_app[:rails].has_key?(:environment)

nginx_app[:database] = {} unless nginx_app.has_key?(:database)
nginx_app[:database][:name] = "#{nginx_app[:name]}_#{nginx_app[:rails][:environment]}" unless nginx_app[:database].has_key?(:name)
nginx_app[:database][:user] = nginx_app[:name] unless nginx_app[:database].has_key?(:user)

nginx_app[:extra_lines] = [] unless nginx_app.has_key?(:extra_lines)

unless nginx_app[:database].has_key?(:password)
  password = ""
  chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
  20.times { |i| password << chars[rand(chars.size-1)] }
  nginx_app[:database][:password] = password 
end