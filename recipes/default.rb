#
# Cookbook Name:: taurus
# Recipe:: default
#
include_recipe 'taurus::_common'
include_recipe 'taurus::taurus'

include_recipe 'taurus::firewall' if node['taurus']['firewall_support']
include_recipe 'taurus::jmeter' if node['taurus']['jmeter_support']
include_recipe 'taurus::locustio' if node['taurus']['locustio_support']
include_recipe 'taurus::ab' if node['taurus']['ab_support']
include_recipe 'taurus::siege' if node['taurus']['siege_support']
include_recipe 'taurus::gatling' if node['taurus']['gatling_support']
include_recipe 'taurus::tsung' if node['taurus']['tsung_support']
