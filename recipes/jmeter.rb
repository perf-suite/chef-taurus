#
# Cookbook Name:: taurus
# Recipe:: jmeter
#

include_recipe 'java'

ark 'jmeter' do
  url node['taurus']['jmeter']['source_url']
  version node['taurus']['jmeter']['version']
  path node['taurus']['jmeter']['path']
  has_binaries ['bin/jmeter', 'bin/jmeter-server', 'bin/ApacheJMeter.jar']
  append_env_path true
  action :install
end

template "#{node['taurus']['jmeter']['path']}/bin/user.properties" do
  variables(
    jmeter_server_rmi_port: node['taurus']['jmeter']['server_rmi_port'],
    jmeter_client_rmi_port: node['taurus']['jmeter']['client_rmi_port']
  )
  source 'jmeter-user-properties.erb'
  mode '0644'
end

plugin_mirror = node['taurus']['jmeter']['plugins']['mirror_source']
plugin_version = node['taurus']['jmeter']['plugins']['version']
plugin_list = node['taurus']['jmeter']['plugins']['list']

plugin_list.each do |plugin_name|
  plugin_url = "JMeterPlugins-#{plugin_name}-#{plugin_version}.zip"
  ark "jmeter-plugin-#{plugin_name}" do
    url "#{plugin_mirror}/#{plugin_url}"
    path "#{node['taurus']['jmeter']['path']}/lib"
    action :dump
  end
end

# JMeter Server (runit) for Distributed
if node['taurus']['jmeter_service']
  include_recipe 'runit'

  directory node['taurus']['jmeter']['log_dir'] do
    action :create
    owner node['taurus']['user']
    group node['taurus']['group']
    recursive true
  end

  runit_service 'jmeter-service' do
    sv_timeout 15
    default_logger true
    action :create
  end

  template '/etc/service/jmeter-service/control/d' do
    source 'sv-jmeter-service-down.erb'
    owner 'root'
    group 'root'
    mode '0744'
    notifies :restart, 'runit_service[jmeter-service]'
  end
end

# TODO: support jar files for mysql, activemq, plugins manager, etc
#
# ark 'connector' do
#   url node['taurus']['url']
#   path "#{node['']}/lib/ext"
#   owner node['taurus']['user']
#   action :cherry_pick
# end
#
# http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.38.tar.gz
# =>  'mysql-connector-java-5.1.38-bin.jar'
# http://www.apache.org/dyn/closer.cgi?filename=/activemq/5.13.3/apache-activemq-5.13.3-bin.tar.gz&action=download
# http://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-manager/0.5/jmeter-plugins-manager-0.5.jar
# http://jmeter-plugins.org/downloads/file/ServerAgent-2.2.1.zip
#
