#
# Cookbook Name:: taurus
# Recipe:: taurus
#

user node['taurus']['user'] do
  home node['taurus']['home']
  shell '/bin/bash'
  action :create
end

group node['taurus']['group'] do
  action :create
end

directory node['taurus']['home'] do
  action :create
  owner node['taurus']['user']
  group node['taurus']['group']
  mode '0755'
end

python_pip 'bzt' do
  version node['taurus']['version'] if node['taurus']['version']
  options node['taurus']['python']['pip_options'] if node['taurus']['python']['pip_options']
  action :install
end

directory node['taurus']['conf_dir'] do
  action :create
  owner 'root'
  group 'root'
  mode '0755'
end

template "#{node['taurus']['conf_dir']}/#{node['taurus']['conf_file']}" do
  variables(
    check_updates: node['taurus']['settings']['check-updates'],
    check_interval: node['taurus']['settings']['check-interval'],
    default_executor: node['taurus']['settings']['default-executor'],
    artifacts_dir: node['taurus']['settings']['artifacts-dir'],
    jmeter_support: node['taurus']['jmeter_support'],
    jmeter_path: node['taurus']['jmeter']['path'],
    gatling_support: node['taurus']['gatling_support'],
    gatling_path: node['taurus']['gatling']['path']
  )
  source 'bzt-rc.erb'
  mode '0644'
end
