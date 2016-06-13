#
# Cookbook Name:: taurus
# Recipe:: siege
#

package_list = value_for_platform('ubuntu' => { 'default' => node['taurus']['siege']['package']['list_ubuntu'] },
                                  'default' => node['taurus']['siege']['package']['list'])

package_list.each do |package_name|
  package package_name do
    action :install
  end
end
