include_recipe "database::mysql"


# This is used repeatedly, so we'll store it in a variable
mysql_connection_info = {
  host:     'localhost',
  username: 'root',
  password: node['mysql']['server_root_password']
}

# Ensure a database exists with the name of our app
mysql_database node[:test_site][:db_name] do
  connection mysql_connection_info
  action     :create
end
mysql_database node[:test_site][:testdb_name] do
  connection mysql_connection_info
  action     :create
end

# Ensure a database user exists with the name of our app
mysql_database_user node[:test_site][:db_user] do
  connection mysql_connection_info
  password   node[:test_site][:db_password]
  action     :create
end
mysql_database_user node[:test_site][:testdb_user] do
  connection mysql_connection_info
  password   node[:test_site][:db_password]
  action     :create
end

# Let this database user access this database
mysql_database_user node[:test_site][:db_user] do
  mysql_connection_info
  password      node[:test_site][:db_password]
  database_name node[:test_site][:db_name]
  host          'localhost'
  action        :grant
end
mysql_database_user node[:test_site][:testdb_user] do
  mysql_connection_info
  password      node[:test_site][:db_password]
  database_name node[:test_site][:testdb_name]
  host          'localhost'
  action        :grant
end


# build mysite.cnf for mysql config
include_recipe 'mysql::server'

template '/etc/mysql/conf.d/mysite.cnf' do
  owner 'mysql'
  owner 'mysql'      
  source 'mysite.cnf.erb'
  notifies :restart, 'mysql_service[default]'
end

# restart mysql
execute "restart_mysql" do
  command "sudo service mysql restart"
end
