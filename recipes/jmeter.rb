#
# Cookbook Name:: taurus
# Recipe:: jmeter
#

include_recipe 'java'

directory node['taurus']['jmeter']['path'] do
  action :create
  owner node['taurus']['user']
  group node['taurus']['group']
  recursive true
end

ark 'jmeter' do
  action :put
  url node['taurus']['jmeter']['source_url']
  path "#{node['taurus']['home']}/tools"
  owner node['taurus']['user']
end

jmeter_binaries = ['bin/jmeter', 'bin/jmeter-server', 'bin/ApacheJMeter.jar']

jmeter_binaries.each do |binary_name|
  file "#{node['taurus']['jmeter']['path']}/#{binary_name}" do
    mode '0755'
  end
end

plugin_mirror = node['taurus']['jmeter']['plugins']['mirror_source']
plugin_version = node['taurus']['jmeter']['plugins']['version']
plugin_list = node['taurus']['jmeter']['plugins']['list']

plugin_list.each do |plugin_name|
  plugin_url = "JMeterPlugins-#{plugin_name}-#{plugin_version}.zip"
  ark 'lib' do
    action :put
    url "#{plugin_mirror}/#{plugin_url}"
    path node['taurus']['jmeter']['path']
    owner node['taurus']['user']
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
