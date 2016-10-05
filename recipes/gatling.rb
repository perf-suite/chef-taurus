#
# Cookbook Name:: taurus
# Recipe:: gatling
#

include_recipe 'java'

ark 'gatling' do
  url node['taurus']['gatling']['source_url']
  version node['taurus']['gatling']['version']
  path node['taurus']['gatling']['path']
  has_binaries ['bin/gatling.sh', 'bin/recorder.sh']
  append_env_path true
  action :install
end
