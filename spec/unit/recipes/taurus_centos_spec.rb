
require 'spec_helper'

describe 'taurus::taurus' do
  context 'centos' do
    let(:runner) { ChefSpec::SoloRunner.new(CENTOS_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) { runner.converge(described_recipe) }

    installed_python_pip = %w(bzt)
    omitted_python_pip = %w(bzttools)

    it 'creates taurus group' do
      expect(chef_run).to create_group('taurus')
    end

    it 'creates taurus user' do
      expect(chef_run).to create_user('taurus')
    end

    it 'creates taurus directory /opt/taurus' do
      expect(chef_run).to create_directory('/opt/taurus')
    end

    it 'creates taurus config /etc/bzt.d' do
      expect(chef_run).to create_directory('/etc/bzt.d')
    end

    it 'creates templates /etc/bzt.d/66-chef.yml' do
      expect(chef_run).to create_template('/etc/bzt.d/66-chef.yml')
    end

    it 'renders /etc/bzt.d/66-chef.yml with content' do
      expect(chef_run).to render_file('/etc/bzt.d/66-chef.yml').with_content { |content|
        expect(content).to match(/settings:/)
        expect(content).to match(/check-updates:/)
        expect(content).to match(/default-executor:/)
      }
    end

    installed_python_pip.each do |p|
      it "installs the python pip #{p}" do
        expect(chef_run).to install_python_pip(p)
      end
    end

    omitted_python_pip.each do |p|
      it "does not install the python pip #{p}" do
        expect(chef_run).to_not install_python_pip(p)
      end
    end
  end
end
