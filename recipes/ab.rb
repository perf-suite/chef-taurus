#
# Cookbook Name:: taurus
# Recipe:: ab
#

package_list = value_for_platform('ubuntu' => { 'default' => node['taurus']['ab']['package']['list_ubuntu'] },
                                  'default' => node['taurus']['ab']['package']['list'])

package_list.each do |package_name|
  package package_name do
    action :install
  end
end
