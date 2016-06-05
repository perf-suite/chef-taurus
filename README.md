# taurus Cookbook
=======================

Configures a system with taurus to execute performance testing.

[Blazemeter Taurus][2] using [installation instructions][3]

Using the following Open Source Performance Tools

[Apache JMeter][4] using [best practices][5]
[Locustio locust][6] using [installation instructions][7]

Additional tools to follow in later release.
ab
gatling
seige
tsung

Requirements
------------

#### Cookbooks

The dependency cookbooks are:
- [ark][9]
- [build-essential][13]
- [yum-epel][12]
- [java][10]
- [python][11]

#### Attributes

Key | Type | Description | Default
--- | ---- | ----------- | -------
['taurus']['jdk_version'] | String | Version of JDK to install | '7'
['taurus']['jmeter_support'] | Bool | Enable support for Apache JMeter | 'true'
['taurus']['locustio_support'] | Bool | Enable support for Locust | 'true'
['taurus']['user'] | String | User for executing load test | 'taurus'
['taurus']['group'] | String | Group associated to running load test | 'taurus'
['taurus']['home'] | String | Home Folder for User | '/opt/taurus'
['taurus']['version'] | String | Specific version of Taurus to install | '1.6.1

Key | Type | Description | Default
--- | ---- | ----------- | -------
['taurus']['jmeter']['version'] | String | Version of Apache JMeter to install | '2.13'
['taurus']['jmeter']['path'] | String | Default path to install Apache JMeter | '/opt/taurus/tools/jmeter'
['taurus']['jmeter']['mirror_source'] | String | Website to pull packages | 'https://archive.apache.org/dist/jmeter/binaries'
['taurus']['jmeter']['source_url'] | String | Download link for Apache JMeter | "#{node['taurus']['jmeter']['mirror_source']}/apache-jmeter-#{node['taurus']['jmeter']['version']}.zip"

Key | Type | Description | Default
--- | ---- | ----------- | -------
['taurus']['jmeter']['plugins']['version'] | String | Version of Apache JMeter Plugin | '1.4.0'
['taurus']['jmeter']['plugins']['list'] | Array | Plugins to install for Apache JMeter | 'Standard Extras ExtrasLibs WebDriver XMPP Hadoop'
['taurus']['jmeter']['plugins']['mirror_source'] | String | Website to pull packages | 'http://jmeter-plugins.org/files'

Key | Type | Description | Default
--- | ---- | ----------- | -------
['taurus']['locustio']['version'] | String | Version of Locust to install| '0.7.5'

#### Supported Platforms

- Centos 7.1

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
