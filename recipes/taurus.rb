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
  mode '0700'
end

directory "#{node['taurus']['home']}/.bzt" do
  action :create
  owner node['taurus']['user']
  group node['taurus']['group']
end

template "#{node['taurus']['home']}/.bzt-rc" do
  variables(
    check_updates: node['taurus']['settings']['check-updates'],
    check_interval: node['taurus']['settings']['check-interval'],
    default_executor: node['taurus']['settings']['default-executor'],
    artifacts_dir: node['taurus']['settings']['artifacts-dir'],
    jmeter_path: node['taurus']['jmeter']['path']
  )
  source 'bzt-rc.erb'
  owner node['taurus']['user']
  group node['taurus']['group']
  mode '0755'
end

python_pip 'bzt' do
  version node['taurus']['version']
  action :install
end
