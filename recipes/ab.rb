#
# Cookbook Name:: taurus
# Recipe:: ab
#

pkg_name = 'httpd-tools'
pkg_name = 'apache2-utils' if node['platform'] == 'ubuntu'

package pkg_name do
  version node['taurus']['ab']['version'] if node['taurus']['ab']['version']
  action :install
end
