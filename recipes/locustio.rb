#
# Cookbook Name:: taurus
# Recipe:: locustio
#

python_pip 'locustio' do
  version node['taurus']['locustio']['version']
  action :install
end

# LocustIO Server (runit) for Distributed
if node['taurus']['locustio_service']
  include_recipe 'runit'

  directory node['taurus']['locustio']['log_dir'] do
    action :create
    owner node['taurus']['user']
    group node['taurus']['group']
    recursive true
  end

  template "#{node['taurus']['home']}/taurus_locustfile.py" do
    source 'locustfile-py.erb'
    owner node['taurus']['user']
    group node['taurus']['group']
    mode '0755'
  end

  runit_service 'locustio-service' do
    sv_timeout 15
    default_logger true
    action :create
  end
end
