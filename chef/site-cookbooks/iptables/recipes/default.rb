#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'simple_iptables'

# Reject packets other than those explicitly allowed
simple_iptables_policy "INPUT" do
  policy "DROP"
end

# The following rules define a "system" chain; chains
# are used as a convenient way of grouping rules together,
# for logical organization.

# Allow all traffic on the loopback device
simple_iptables_rule "loopback" do
  chain "system"
  rule "--in-interface lo"
  jump "ACCEPT"
end

# Allow any established connections to continue, even
# if they would be in violation of other rules.
simple_iptables_rule "established" do
  chain "system"
  rule "-m conntrack --ctstate ESTABLISHED,RELATED"
  jump "ACCEPT"
end

# Allow SSH
simple_iptables_rule "ssh" do
  chain "system"
  rule "--proto tcp --dport 22"
  jump "ACCEPT"
end

# Allow HTTP
simple_iptables_rule "http" do
  rule [ "--proto tcp --dport 80 --source #{node[:iptables][:till2014ip1]}",
         "--proto tcp --dport 80 --source #{node[:iptables][:till2014ip2]}",
         "--proto tcp --dport 80 --source #{node[:iptables][:aftr2014ip1]}",
         "--proto tcp --dport 80 --source #{node[:iptables][:aftr2014ip2]}",
         "--proto tcp --dport 443 --source #{node[:iptables][:till2014ip1]}",
         "--proto tcp --dport 443 --source #{node[:iptables][:till2014ip2]}",
         "--proto tcp --dport 443 --source #{node[:iptables][:aftr2014ip1]}",
         "--proto tcp --dport 443 --source #{node[:iptables][:aftr2014ip2]}" ]
  jump "ACCEPT"
end
