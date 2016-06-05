#
# Cookbook Name:: taurus
# Recipe:: locustio
#

python_pip 'locustio' do
  version node['taurus']['locustio']['version']
  action :install
end
