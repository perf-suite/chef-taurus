require 'spec_helper'

describe 'taurus::firewall' do
  context 'ubuntu' do
    context 'When firewall_support attributes is enabled' do
      let(:runner) { ChefSpec::SoloRunner.new(CHEFSPEC_OPTS) }
      let(:node) { runner.node }
      let(:chef_run) do
        node.set['taurus']['firewall_support'] = true
        node.set['taurus']['jmeter_service'] = true
        node.set['taurus']['locustio_service'] = true
        runner.converge(described_recipe)
      end

      it 'installs a firewall' do
        expect(chef_run).to install_firewall('default')
      end

      it 'add firewall access to jmeter service ports' do
        expect(chef_run).to create_firewall_rule('jmeter_master_udp').with(
          protocol: :udp, port: [1098, 1099],
          direction: :in, command: :allow
        )
        expect(chef_run).to create_firewall_rule('jmeter_master_tcp').with(
          protocol: :tcp, port: [1098, 1099],
          direction: :in, command: :allow
        )
      end
      it 'add firewall access to locustio service ports' do
        expect(chef_run).to create_firewall_rule('locustio_master_tcp').with(
          protocol: :tcp, port: [5557, 5558],
          direction: :in, command: :allow
        )
        expect(chef_run).to create_firewall_rule('locustio_web_tcp').with(
          protocol: :tcp, port: 8089,
          direction: :in, command: :allow
        )
      end
    end
  end

  context 'When firewall_support attributes is disabled' do
    let(:runner) { ChefSpec::SoloRunner.new(CHEFSPEC_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) do
      node.set['taurus']['firewall_support'] = false
      runner.converge(described_recipe)
    end
    it 'does not install iptables' do
      expect(chef_run).to_not install_package('iptables')
    end
  end
end
