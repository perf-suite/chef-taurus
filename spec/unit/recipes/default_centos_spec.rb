require 'spec_helper'

describe 'taurus::default' do
  context 'centos' do
    context 'When all attributes are default' do
      let(:runner) { ChefSpec::SoloRunner.new(CENTOS_OPTS) }
      let(:node) { runner.node }
      let(:chef_run) do
        runner.node.set['platform'] = 'centos'
        runner.node.set['yum']['epel']['enabled'] = true

        runner.converge(described_recipe)
      end

      included_recipes = [
        'taurus::_common',
        'taurus::taurus',
        'taurus::jmeter',
        'taurus::locustio',
        'taurus::ab',
        'taurus::siege',
        'taurus::gatling',
        'taurus::tsung'
      ]
      excluded_recipes = %w(taurus::firewall)

      included_recipes.each do |r|
        it "includes the recipe #{r}" do
          expect(chef_run).to include_recipe(r)
        end
      end

      it 'excludes the recipes' do
        excluded_recipes.each do |r|
          expect(chef_run).not_to include_recipe(r)
        end
      end

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end
    end
  end
end
