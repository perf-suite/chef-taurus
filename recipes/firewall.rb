#
# Cookbook Name:: taurus
# Recipe:: firewall
#

include_recipe 'firewall'

if node['taurus']['jmeter_service']
  firewall_rule 'jmeter_master_udp' do
    protocol :udp
    port [node['taurus']['jmeter']['server_rmi_port'],
          node['taurus']['jmeter']['client_rmi_port']]
    action :create
  end

  firewall_rule 'jmeter_master_tcp' do
    protocol :tcp
    port [node['taurus']['jmeter']['server_rmi_port'],
          node['taurus']['jmeter']['client_rmi_port']]
    action :create
  end
end

if node['taurus']['locustio_service'] && !node['taurus']['master_host']
  firewall_rule 'locustio_master_tcp' do
    protocol :tcp
    port [node['taurus']['locustio']['master_port'],
          node['taurus']['locustio']['master_port'] + 1]
    action :create
  end

  firewall_rule 'locustio_web_tcp' do
    protocol :tcp
    port node['taurus']['locustio']['web_port']
    action :create
  end
end
