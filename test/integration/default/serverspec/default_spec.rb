require 'spec_helper'

describe group('taurus') do
  it { should exist }
end

describe user('taurus') do
  it { should exist }
  it { should belong_to_group('taurus') }
  it { should have_login_shell('/bin/bash') }
end

describe file('/opt/taurus') do
  it { should be_directory }
  it { should be_owned_by 'taurus' }
  it { should be_grouped_into 'taurus' }
  it { should be_mode 700 }
end

content = [
  '---',
  'settings:',
  '  check-updates: false',
  '  check-interval: 5s',
  '  default-executor: jmeter',
  '  artifacts-dir: /tmp/taurus-%Y-%m-%d_%H-%M-%S.%f',
  '',
  'modules:',
  '  jmeter:',
  '    path: /opt/taurus/tools/jmeter'
].join("\n") << "\n"

describe file('/opt/taurus/.bzt-rc') do
  it { should be_file }
  it { should be_owned_by 'taurus' }
  it { should be_grouped_into 'taurus' }
  it { should be_mode 755 }
  its(:content) { should eq content }
end

describe command('bzt -h') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match %r{BlazeMeter Taurus Tool v1.6.1} }
end

describe command('/usr/bin/java -version') do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should match %r{java version \"1.7} }
end

describe file('/etc/profile.d/jdk.sh') do
  it { should be_file }
  it { should be_mode 755 }
  its(:content) { should contain 'export JAVA_HOME' }
end

describe file('/opt/taurus/tools/jmeter') do
  it { should be_directory }
  it { should be_owned_by 'taurus' }
  it { should be_mode 755 }
end

describe command('/opt/taurus/tools/jmeter/bin/jmeter --version') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match %r{Version 2.13} }
end

describe command('locust --version 2>&1') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match %r{Locust 0.7.5} }
end

describe command('ab -V 2>&1') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match %r{ApacheBench, Version 2} }
end
