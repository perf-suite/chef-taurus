# taurus Cookbook

[![Chef cookbook](https://img.shields.io/cookbook/v/taurus.svg?maxAge=2592000?style=flat-square)](https://supermarket.chef.io/cookbooks/taurus)
[![Build Status](https://travis-ci.org/perf-suite/chef-taurus.svg?branch=master)](https://travis-ci.org/perf-suite/chef-taurus)

This cookbook installs and configures a system with taurus to execute performance testing.

[Blazemeter Taurus][2] using [installation instructions][3]

Includes support for the following Open Source Performance Tools

- [Apache Benchmark][19]
- [Apache JMeter][4] using [best practices][5] with [runit service][24] for [server mode][23]
- [Gatling][18]
- [Locustio locust][6] using [installation instructions][7] with [runit service][24] for [distributed mode][25]
- [Siege][17]
- [Tsung][14] using [installation instructions][15]

Requirements
------------

#### Cookbooks

The dependency cookbooks are:
- [ark][9]
- [build-essential][13]
- [apt][20]
- [yum-epel][12] '= 1.0.1' with  'yum = 3.13.0'
- [java][10]
- [python][11]
- [erlang][16]

#### Attributes

[Blazemeter Taurus][2] global attributes

Key | Type | Description | Default
--- | ---- | ----------- | -------
['taurus']['firewall_support'] | Bool | Turn on firewall support | 'false'
['taurus']['jdk_version'] | String | Version of JDK to install | '7'
['taurus']['erlang']['gui_tools'] | String | (Tsung) Whether to install the GUI tools for Erlang | 'false'
['taurus']['erlang']['install_method'] | String | (Tsung) Erlang installation method | 'package'
['taurus']['jmeter_support'] | Bool | Enable support for Apache JMeter | 'true'
['taurus']['jmeter_service'] | Bool | Install JMeter as a Service (runit) to support distributed mode | 'false'
['taurus']['locustio_support'] | Bool | Enable support for Locust | 'true'
['taurus']['locustio_service'] | Bool | Install LocustIO as a Service (runit) to support distributed mode | 'false'
['taurus']['ab_support'] | Bool | Enable support for Apache Benchmark | 'true'
['taurus']['siege_support'] | Bool | Enable support for Siege | 'true'
['taurus']['gatling_support'] | Bool | Enable support for Gatling | 'true'
['taurus']['tsung_support'] | Bool | Enable support for Tsung | 'true'
['taurus']['user'] | String | User for executing load test | 'taurus'
['taurus']['group'] | String | Group associated to running load test | 'taurus'
['taurus']['home'] | String | Home Folder for User | '/opt/taurus'
['taurus']['version'] | String | Specific version of Taurus to install | '1.6.8'
['taurus']['conf_dir'] | String | Location to store Taurus configs globally | '/etc/bzt.d'
['taurus']['conf_config'] | String | Filename of Taurus config | '66-chef.yml'

[Apache JMeter][4]

Key | Type | Description | Default
--- | ---- | ----------- | -------
['taurus']['jmeter']['version'] | String | Version of Apache JMeter to install | '3.0'
['taurus']['jmeter']['path'] | String | Default path to install Apache JMeter | '/usr/local/jmeter-3.0'
['taurus']['jmeter']['mirror_source'] | String | Website to pull packages | 'https://archive.apache.org/dist/jmeter/binaries'
['taurus']['jmeter']['source_url'] | String | Download link for Apache JMeter | "#{node['taurus']['jmeter']['mirror_source']}/apache-jmeter-#{node['taurus']['jmeter']['version']}.zip"

[JMeter Server (runit) for Distributed][23]

Key | Type | Description | Default
--- | ---- | ----------- | -------
['taurus']['jmeter']['plugins']['server_rmi_port'] | String | RMI Server Port to Listen on | '1098'
['taurus']['jmeter']['plugins']['client_rmi_port'] | String | RMI Server Port to Listen on | '1099'
['taurus']['jmeter']['plugins']['log_dir'] | String | JMeter Service Log Folder | '/var/log/jmeter-service'

[Apache JMeter Plugins][22]

Key | Type | Description | Default
--- | ---- | ----------- | -------
['taurus']['jmeter']['plugins']['version'] | String | Version of Apache JMeter Plugin | '1.4.0'
['taurus']['jmeter']['plugins']['list'] | Array | Plugins to install for Apache JMeter | 'Standard Extras ExtrasLibs WebDriver XMPP Hadoop'
['taurus']['jmeter']['plugins']['mirror_source'] | String | Website to pull packages | 'http://jmeter-plugins.org/files'

[Apache Benchmark][19] attributes

Key | Type | Description | Default
--- | ---- | ----------- | -------
['taurus']['ab']['version'] | String | Version of Apache Benchmark| 'nil'

[Gatling][18] attributes

Key | Type | Description | Default
--- | ---- | ----------- | -------
['taurus']['gatling']['version'] | String | Version of Gatling| '2.1.7'
['taurus']['gatling']['path'] | String | Default path to install Gatling | '/usr/local/gatling-2.1.7'
['taurus']['gatling']['mirror_source'] | String | Website to pull packages | 'https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/#{node['taurus']['gatling']['version']}'
['taurus']['gatling']['source_url'] | String | Download link for Gatling | "#{node['taurus']['gatling']['mirror_source']}/gatling-charts-highcharts-bundle-#{node['taurus']['gatling']['version']}-bundle.zip"

[Locustio locust][6] attributes

Key | Type | Description | Default
--- | ---- | ----------- | -------
['taurus']['locustio']['version'] | String | Version of Locust to install| '0.7.5'

[Locustio Server (runit) for Distributed][25]

Key | Type | Description | Default
--- | ---- | ----------- | -------
['taurus']['locustio']['master_host'] | String | Hostname or IP of the master node | 'nil'
['taurus']['locustio']['master_port'] | String | Master Port to Listen on | '5557'
['taurus']['locustio']['web_port'] | String | Master Web Service Port to Listen on | '8089'
['taurus']['locustio']['log_dir'] | String | LocustIO Service Log Folder | '/var/log/locustio-service'

[Siege][17] attributes

Key | Type | Description | Default
--- | ---- | ----------- | -------
['taurus']['siege']['version'] | String | Version of Siege| 'nil'

[Tsung][14] attributes

Key | Type | Description | Default
--- | ---- | ----------- | -------
['taurus']['tsung']['version'] | String | Version of Tsung| '1.6.0'
['taurus']['tsung']['mirror_source'] | String | Website to pull packages | 'http://tsung.erlang-projects.org/dist'
['taurus']['tsung']['source_url'] | String | Download link for Tsung| '#{node['taurus']['tsung']['mirror_source']}/tsung-#{node['taurus']['tsung']['version']}.tar.gz'

#### Supported Platforms

- Centos 7.1
- Ubuntu 16.04

Usage
-----

Maintainers
-------------------
- Author:: [Performance Suite][1]  (<perf-suite@outlook.com>)

[1]: https://github.com/perf-suite
[2]: http://gettaurus.org/
[3]: http://gettaurus.org/docs/Installation/
[4]: http://jmeter.apache.org/
[5]: http://jmeter.apache.org/usermanual/best-practices.html
[6]: http://locust.io/
[7]: http://docs.locust.io/en/latest/installation.html
[8]: https://github.com/Blazemeter/taurus
[9]: https://github.com/chef-cookbooks/ark
[10]: https://github.com/agileorbit-cookbooks/java
[11]: https://github.com/poise/python
[12]: https://github.com/chef-cookbooks/yum-epel
[13]: https://github.com/chef-cookbooks/build-essential
[14]: http://tsung.erlang-projects.org/
[15]: http://tsung.erlang-projects.org/user_manual/installation.html
[16]: https://github.com/chef-cookbooks/erlang
[17]: https://www.joedog.org/siege-home
[18]: http://gatling.io/
[19]: https://github.com/gatling/gatling
[20]: https://github.com/chef-cookbooks/apt
[21]: https://supermarket.chef.io/cookbooks/taurus
[22]: http://jmeter-plugins.org
[23]: http://jmeter.apache.org/usermanual/remote-test.html
[24]: https://github.com/chef-cookbooks/runit
[25]: http://docs.locust.io/en/latest/running-locust-distributed.html
