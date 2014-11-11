directory node[:test_site][:cake_source] + '/app/tmp' do
 owner "www-data"
 group "www-data"
 mode "0777"
end
directory node[:test_site][:cake_source] + '/app/tmp/cache' do
 owner "www-data"
 group "www-data"
 mode "0777"
end
directory node[:test_site][:cake_source] + '/app/tmp/cache' + '/models' do
 owner "www-data"
 group "www-data"
 mode "0777"
end
directory node[:test_site][:cake_source] + '/app/tmp/cache' + '/persistent' do
 owner "www-data"
 group "www-data"
 mode "0777"
end
directory node[:test_site][:cake_source] + '/app/tmp/cache' + '/views' do
 owner "www-data"
 group "www-data"
 mode "0777"
end
directory node[:test_site][:cake_source] + '/app/tmp/logs' do
 owner "www-data"
 group "www-data"
 mode "0777"
end
directory node[:test_site][:cake_source] + '/app/tmp/sessions'  do
 owner "www-data"
 group "www-data"
 mode "0777"
end
directory node[:test_site][:cake_source] + '/app/tmp/tests'  do
 owner "www-data"
 group "www-data"
 mode "0777"
end
# remove files in tmp directory
execute "init_tmp" do
  command "find " + node[:test_site][:cake_source] + '/app/tmp -type f -exec rm {} \;'
end
# build mysql tables for the project
execute "init_mysql_tables" do
  command "mysql -u" + node[:test_site][:db_user] + " -p" + node[:test_site][:db_password] + " " + node[:test_site][:db_name] + " < " + node[:test_site][:cake_source] + "/app/Config/sql/init_tables.sql"
end

# file node[:test_site][:cake_source] + '/app/Config/database.php' do
#   content IO.read(node[:test_site][:cake_source] + '/app/Config/database.php.default')
# end
template node[:test_site][:cake_source] + '/app/Config/database.php' do
  source 'cake_database.erb'
  owner "www-data"
  group "www-data"
  variables({
     :login         => node[:test_site][:db_user],
     :database      => node[:test_site][:db_name],
     :password      => node[:test_site][:db_password],
     :test_login    => node[:test_site][:testdb_user],
     :test_database => node[:test_site][:testdb_name],
     :test_password => node[:test_site][:db_password]
  })
end
# file node[:test_site][:cake_source] + '/app/Config/database.php.default' do
#   action :delete
# end
