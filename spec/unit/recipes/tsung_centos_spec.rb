require 'spec_helper'

describe 'taurus::tsung' do
  context 'centos' do
    let(:runner) { ChefSpec::SoloRunner.new(CENTOS_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) { runner.converge(described_recipe) }

    included_recipes = %w(erlang)
    installed_package = %w(erlang)

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

    it 'downloads tsung' do
      expect(chef_run).to install_with_make_ark('tsung')
    end
  end
end
