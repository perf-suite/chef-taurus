#
# Cookbook Name:: taurus
# Recipe:: _common
#

include_recipe 'yum-epel' if node['platform'] == 'centos'
include_recipe 'apt' if node['platform'] == 'ubuntu'

include_recipe 'ark'
include_recipe 'build-essential'
include_recipe 'python'
include_recipe 'erlang' if node['taurus']['tsung_support']

package_list = value_for_platform('ubuntu' => { 'default' => node['taurus']['package']['list_ubuntu'] },
                                  'default' => node['taurus']['package']['list'])

package_list.each do |package_name|
  package package_name do
    action :install
  end
end

python_list = node['taurus']['python']['list']

python_list.each do |python_name|
  python_pip python_name do
    options node['taurus']['python']['pip_options'] if node['taurus']['python']['pip_options']
    action :install
  end
end
