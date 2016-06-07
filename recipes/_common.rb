#
# Cookbook Name:: taurus
# Recipe:: _common
#

include_recipe 'ark'
include_recipe 'build-essential'

include_recipe 'yum-epel' if node['platform_family'] == 'centos'
include_recipe 'apt' if node['platform_family'] == 'ubuntu'

include_recipe 'python'

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
    action :install
  end
end
