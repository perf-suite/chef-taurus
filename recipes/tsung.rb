#
# Cookbook Name:: taurus
# Recipe:: tsung
#

include_recipe 'erlang'

ark 'tsung' do
  version node['taurus']['tsung']['version']
  url node['taurus']['tsung']['source_url']
  action :install_with_make
end
