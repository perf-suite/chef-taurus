require 'spec_helper'

describe 'taurus::ab' do
  context 'centos' do
    let(:runner) { ChefSpec::SoloRunner.new(CENTOS_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) { runner.converge(described_recipe) }

    installed_package = %w(httpd-tools)
    omitted_package = %w(apache2-utils)

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
  end
end
