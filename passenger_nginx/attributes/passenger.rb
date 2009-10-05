passenger Mash.new unless attribute?("passenger")

passenger[:version]          = "2.2.5" unless passenger.has_key?(:version)
passenger[:root_path]        = "#{languages[:ruby][:gems_dir]}/gems/passenger-#{passenger[:version]}"
