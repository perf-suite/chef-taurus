#
# Cookbook Name:: taurus
default['taurus']['firewall_support'] = false

default['java']['jdk_version'] = '7'
default['erlang']['gui_tools'] = false
default['erlang']['install_method'] = 'package'

default['taurus']['jmeter_support'] = true
default['taurus']['jmeter_service'] = false
default['taurus']['locustio_support'] = true
default['taurus']['locustio_service'] = false
default['taurus']['ab_support'] = true
default['taurus']['siege_support'] = true
default['taurus']['gatling_support'] = true
default['taurus']['tsung_support'] = true

default['taurus']['user'] = 'taurus'
default['taurus']['group'] = 'taurus'
default['taurus']['home'] = '/opt/taurus'
default['taurus']['conf_dir'] = '/etc/bzt.d'
default['taurus']['conf_file'] = '66-chef.yml'
default['taurus']['version'] = '1.6.8'
default['taurus']['sv_timeout'] = 15

default['taurus']['settings']['check-updates'] = 'false'
default['taurus']['settings']['check-interval'] = '5s'
default['taurus']['settings']['default-executor'] = 'jmeter'
default['taurus']['settings']['artifacts-dir'] = 'taurus-%Y-%m-%d_%H-%M-%S.%f'

default['taurus']['package']['list'] = ['python-devel', 'python-pip',
                                        'python-virtualenv', 'libxml2-devel',
                                        'libxslt-devel', 'zlib']

default['taurus']['package']['list_ubuntu'] = ['python-dev', 'python-pip',
                                               'python-virtualenv', 'libxml2-dev',
                                               'libxslt1-dev', 'zlib1g']

default['taurus']['python']['list'] = %w(lxml psutil pyzmq gevent)
default['taurus']['python']['pip_options'] = nil

# JMeter
default['taurus']['jmeter']['version'] = '3.0'
default['taurus']['jmeter']['path'] = "/usr/local/jmeter-#{node['taurus']['jmeter']['version']}"
default['taurus']['jmeter']['mirror_source'] = 'https://archive.apache.org/dist/jmeter/binaries'
default['taurus']['jmeter']['source_url'] = "#{node['taurus']['jmeter']['mirror_source']}/apache-jmeter-#{node['taurus']['jmeter']['version']}.zip"

# JMeter Server (runit) for Distributed
default['taurus']['jmeter']['server_rmi_port'] = 1098
default['taurus']['jmeter']['client_rmi_port'] = 1099
default['taurus']['jmeter']['log_dir'] = '/var/log/jmeter-service'

# JMeter plugins
default['taurus']['jmeter']['plugins']['version'] = '1.4.0'
default['taurus']['jmeter']['plugins']['list'] = %w(Standard Extras ExtrasLibs WebDriver XMPP Hadoop)
default['taurus']['jmeter']['plugins']['mirror_source'] = 'http://jmeter-plugins.org/files'

# LocustIO
default['taurus']['locustio']['version'] = '0.7.5'

# LocustIO Server (runit) for Distributed
default['taurus']['locustio']['master_host'] = nil
default['taurus']['locustio']['master_port'] = 5557
default['taurus']['locustio']['web_port'] = 8089
default['taurus']['locustio']['log_dir'] = '/var/log/locustio-service'

# Apache Benchmark
default['taurus']['ab']['version'] = nil

# Siege
default['taurus']['siege']['version'] = nil

# Gatling
default['taurus']['gatling']['version'] = '2.1.7'
default['taurus']['gatling']['path'] = "/usr/local/gatling-#{node['taurus']['gatling']['version']}"
default['taurus']['gatling']['mirror_source'] = "https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/#{node['taurus']['gatling']['version']}"
default['taurus']['gatling']['source_url'] = "#{node['taurus']['gatling']['mirror_source']}/gatling-charts-highcharts-bundle-#{node['taurus']['gatling']['version']}-bundle.zip"

# Tsung
default['taurus']['tsung']['version'] = '1.6.0'
default['taurus']['tsung']['mirror_source'] = 'http://tsung.erlang-projects.org/dist'
default['taurus']['tsung']['source_url'] = "#{node['taurus']['tsung']['mirror_source']}/tsung-#{node['taurus']['tsung']['version']}.tar.gz"
