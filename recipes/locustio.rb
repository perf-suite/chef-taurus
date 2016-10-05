#
# Cookbook Name:: taurus
# Recipe:: locustio
#

python_pip 'locustio' do
  version node['taurus']['locustio']['version'] if node['taurus']['locustio']['version']
  options node['taurus']['python']['pip_options'] if node['taurus']['python']['pip_options']
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
    sv_timeout node['taurus']['sv_timeout']
    default_logger true
    action :create
  end

  template '/etc/service/locustio-service/control/d' do
    source 'sv-locustio-service-down.erb'
    owner 'root'
    group 'root'
    mode '0744'
    notifies :restart, 'runit_service[locustio-service]'
  end
end
