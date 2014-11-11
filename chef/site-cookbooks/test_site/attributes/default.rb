default[:test_site][:app_name]    = 'test_site'
default[:test_site][:server_name] = 'test_site.yourdomain.com'
default[:test_site][:www_root]    = "/var/www"
default[:test_site][:cache_root]  = "/var/cache"
default[:test_site][:log_root]    = "/var/log"
default[:test_site][:app_root]    = "#{node[:test_site][:www_root]}/#{node[:test_site][:app_name]}"

default[:test_site][:db_name]     = 'restaurant_menu'
default[:test_site][:db_user]     = 'restaurant_menu'
default[:test_site][:testdb_name] = 'test_restaurant_menu'
default[:test_site][:testdb_user] = 'restaurant_menu'

default[:test_site][:cake_source] = '/vagrant/src/cakephp-2.5.5'
default[:test_site][:cake_cache]  = "#{node[:test_site][:cache_root]}/#{node[:test_site][:app_name]}"
default[:test_site][:cake_log]    = "#{node[:test_site][:log_root]}/#{node[:test_site][:app_name]}"

# default[:test_site][:deploy_user] = 'vagrant'


# default[:test_site][:db_password] = 'anothersecurepassword'
# node.set_unless['mysql']['server_root_password'] = 'hoge'
default[:test_site][:secretpath] = "/vagrant/src/secrets/data_bag_key"

# look for secret in file pointed to by test_site attribute :secretpath
mysql_secret = Chef::EncryptedDataBagItem.load_secret("#{node[:test_site][:secretpath]}")
mysql_creds = Chef::EncryptedDataBagItem.load("passwords", "mysql", mysql_secret)
if mysql_secret && mysql_passwords = mysql_creds[node.chef_environment] 
  node.set_unless['mysql']['server_root_password'] = mysql_passwords['root']
  node.set_unless['mysql']['server_debian_password'] = mysql_passwords['debian']
  node.set_unless['mysql']['server_repl_password'] = mysql_passwords['repl']
  node.set_unless['test_site']['db_password'] = mysql_passwords['app']
end

# php.ini setting
default['php']['conf_dir'] = '/etc/php5/apache2'
default['php']['directives'] = {
  "date.timezone" => "Asia/Tokyo",
  "short_open_tag" => "On"
}

case node["platform_family"]
when "rhel", "fedora"
  if node['platform_version'].to_f < 6 then
    default['php']['packages'] = ['php53', 'php53-devel', 'php53-cli', 'php53-mbstring', 'php-pear']
  else
    default['php']['packages'] = ['php', 'php-devel', 'php-cli', 'php-mbstring', 'php-pear']
  end
end
