require 'spec_helper'

describe 'taurus::jmeter' do
  context 'centos' do
    let(:runner) { ChefSpec::SoloRunner.new(CENTOS_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) { runner.converge(described_recipe) }

    included_recipes = %w(java)
    installed_package = %w(java-1.7.0-openjdk java-1.7.0-openjdk-devel)
    omitted_package = %w(openjdk-7-jdk)

    included_recipes.each do |r|
      it "includes the recipe #{r}" do
        expect(chef_run).to include_recipe(r)
      end
    end

    installed_package.each do |p|
      it "installs the package #{p}" do
        expect(chef_run).to install_package(p)
      end
    end

    omitted_package.each do |p|
      it "does not install the package #{p}" do
        expect(chef_run).to_not install_package(p)
      end
    end

    it 'downloads and install jmeter' do
      expect(chef_run).to install_ark('jmeter')
    end

    it 'creates template /usr/local/jmeter-3.0/bin/user.properties' do
      expect(chef_run).to create_template('/usr/local/jmeter-3.0/bin/user.properties')
    end

    it 'renders /usr/local/jmeter-3.0/bin/user.properties with content' do
      expect(chef_run).to render_file('/usr/local/jmeter-3.0/bin/user.properties').with_content { |content|
        expect(content).to match(/server.rmi.localport=1098/)
        expect(content).to match(/client.rmi.localport=1099/)
      }
    end

    it 'downloads and install jmeter libraries' do
      expect(chef_run).to dump_ark('jmeter-plugin-Standard')
      expect(chef_run).to dump_ark('jmeter-plugin-Extras')
      expect(chef_run).to dump_ark('jmeter-plugin-ExtrasLibs')
      expect(chef_run).to dump_ark('jmeter-plugin-WebDriver')
      expect(chef_run).to dump_ark('jmeter-plugin-XMPP')
      expect(chef_run).to dump_ark('jmeter-plugin-Hadoop')
    end

    it 'does not create runit_service[jmeter-service]' do
      expect(chef_run).not_to enable_runit_service('jmeter-service')
    end

    it 'does not create template /etc/service/jmeter-service/control/d' do
      expect(chef_run).not_to create_template('/etc/service/jmeter-service/control/d')
    end

    it 'does not render /etc/service/jmeter-service/control/d with content' do
      expect(chef_run).not_to render_file('/etc/service/jmeter-service/control/d').with_content('pkill -f \'^java.*ApacheJMeter.jar\'')
    end

    it 'does not create  directory /var/log/jmeter-service' do
      expect(chef_run).not_to create_directory('/var/log/jmeter-service')
    end
  end
end
