require 'spec_helper'

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
  its(:stdout) { should match %r{3.0} }
end

describe package('runit') do
  it { should be_installed }
end

describe command('sv status jmeter-service') do
  its(:exit_status) { should eq(0) }
  its(:stdout) { should match(/^run: jmeter-service/) }
end
