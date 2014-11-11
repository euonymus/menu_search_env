default[:iptables][:secretpath] = "/vagrant/data_bag_key"

# look for secret in file pointed to by iptables attribute :secretpath
office_ip_secret = Chef::EncryptedDataBagItem.load_secret("#{node[:iptables][:secretpath]}")
office_ip_creds = Chef::EncryptedDataBagItem.load("ips", "office", office_ip_secret)

if office_ip_secret && office_ips = office_ip_creds["till2014"] 
  default[:iptables][:till2014ip1] = office_ips['ip1']
  default[:iptables][:till2014ip2] = office_ips['ip2']
end

if office_ip_secret && office_ips = office_ip_creds["aftr2014"] 
  default[:iptables][:aftr2014ip1] = office_ips['ip1']
  default[:iptables][:aftr2014ip2] = office_ips['ip2']
end
