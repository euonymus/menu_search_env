#
# Cookbook Name:: test_site
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'test_site::apache'
include_recipe 'test_site::mysql'
include_recipe 'test_site::cakephp'
include_recipe 'test_site::php'
# include_recipe 'test_site::git'
#include_recipe 'test_site::wordpress'
