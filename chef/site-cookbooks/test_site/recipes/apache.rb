directory(node[:test_site][:www_root])

web_app(node[:test_site][:app_name]) do
  server_name(node[:test_site][:server_name])
  docroot(node[:test_site][:app_root])
  template('vhost.conf.erb')
end

link node[:test_site][:app_root] do
  to node[:test_site][:cake_source]
end
