require 'spec_helper'

describe 'taurus::gatling' do
  context 'ubuntu' do
    let(:runner) { ChefSpec::SoloRunner.new(CHEFSPEC_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) { runner.converge(described_recipe) }

    included_recipes = %w(java)
    installed_package = %w(openjdk-7-jdk)

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
