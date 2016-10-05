require 'spec_helper'

describe 'taurus::gatling' do
  context 'centos' do
    let(:runner) { ChefSpec::SoloRunner.new(CENTOS_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) { runner.converge(described_recipe) }

    included_recipes = %w(java)
    installed_package = %w(java-1.7.0-openjdk java-1.7.0-openjdk-devel)

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

    it 'downloads and installs gatling' do
      expect(chef_run).to install_ark('gatling')
    end
  end
end
