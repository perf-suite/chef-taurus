#
# Cookbook Name:: taurus
# Recipe:: siege
#

package 'siege' do
  version node['taurus']['siege']['version'] if node['taurus']['siege']['version']
  action :install
end
