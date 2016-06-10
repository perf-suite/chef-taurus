#
# Cookbook Name:: taurus
# Recipe:: gatling
#

include_recipe 'java'

directory node['taurus']['gatling']['path'] do
  action :create
  owner node['taurus']['user']
  group node['taurus']['group']
  recursive true
end

ark 'gatling' do
  action :put
  url node['taurus']['gatling']['source_url']
  path "#{node['taurus']['home']}/tools"
  owner node['taurus']['user']
end

gatling_binaries = ['bin/gatling.sh', 'bin/recorder.sh']

gatling_binaries.each do |binary_name|
  file "#{node['taurus']['gatling']['path']}/#{binary_name}" do
    mode '0755'
  end
end
