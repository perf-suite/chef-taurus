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
  it { should be_mode 755 }
end

describe file('/etc/bzt.d') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 755 }
end

content = [
  '---',
  'settings:',
  '  check-updates: false',
  '  check-interval: 5s',
  '  default-executor: jmeter',
  '  artifacts-dir: taurus-%Y-%m-%d_%H-%M-%S.%f'
].join("\n") << "\n\n"

describe file('/etc/bzt.d/66-chef.yml') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
  its(:content) { should eq content }
end

describe command('bzt -h') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match %r{BlazeMeter Taurus Tool v1.6} }
end

expected_rules = [
  %r{firewall-cmd --direct --add-rule ipv4 filter INPUT 50 -p tcp -m tcp -m multiport --dports 22 -m comment --comment 'allow world to ssh' -j ACCEPT},
  %r{firewall-cmd --direct --add-rule ipv4 filter INPUT 50 -m state --state RELATED,ESTABLISHED -m comment --comment 'established' -j ACCEPT},
  %r{firewall-cmd --direct --add-rule ipv6 filter INPUT 50 -m state --state RELATED,ESTABLISHED -m comment --comment 'established' -j ACCEPT},
  %r{firewall-cmd --direct --add-rule ipv6 filter INPUT 50 -p ipv6-icmp -m comment --comment 'ipv6_icmp' -j ACCEPT},
  %r{firewall-cmd --direct --add-rule ipv4 filter INPUT 50 -p tcp -m tcp -m multiport --dports 5557,5558 -m comment --comment 'locustio_master_tcp' -j ACCEPT},
  %r{firewall-cmd --direct --add-rule ipv6 filter INPUT 50 -p tcp -m tcp -m multiport --dports 5557,5558 -m comment --comment 'locustio_master_tcp' -j ACCEPT},
  %r{firewall-cmd --direct --add-rule ipv4 filter INPUT 50 -p tcp -m tcp -m multiport --dports 8089 -m comment --comment 'locustio_web_tcp' -j ACCEPT},
  %r{firewall-cmd --direct --add-rule ipv6 filter INPUT 50 -p tcp -m tcp -m multiport --dports 8089 -m comment --comment 'locustio_web_tcp' -j ACCEPT}
]

expected_rules2 = [
  %r{.*-p tcp -m tcp -m multiport --dports 5557,5558 .*-j ACCEPT},
  %r{.*-p tcp -m tcp -m multiport --dports 8089 .*-j ACCEPT}
]

expected_ufw = [
  %r{ufw allow in proto tcp to any port 22 from 0.0.0.0/0},
  %r{ufw allow in proto tcp to any port 5557,5558 from any},
  %r{ufw allow in proto tcp to any port 8089 from any}
]

expected_ufw2 = [
  %r{.*-p tcp -m multiport --dports 5557,5558 -j ACCEPT},
  %r{.*-p tcp -m tcp --dport 8089 -j ACCEPT}
]

describe command('iptables-save'), if: redhat? do
  its(:stdout) { should match(/COMMIT/) }

  expected_rules2.each do |r|
    its(:stdout) { should contain(r) }
  end
end

describe service('firewalld'), if: redhat? do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/sysconfig/firewalld-chef.rules'), if: redhat? do
  it { should be_file }

  expected_rules.each do |r|
    its(:content) { should match(r) }
  end
end

describe command('iptables-save'), if: ubuntu? do
  its(:stdout) { should match(/COMMIT/) }

  expected_ufw2.each do |r|
    its(:stdout) { should contain(r) }
  end
end

describe service('ufw'), if: ubuntu? do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/default/ufw-chef.rules'), if: ubuntu? do
  it { should be_file }

  expected_ufw.each do |r|
    its(:content) { should match(r) }
  end
end
