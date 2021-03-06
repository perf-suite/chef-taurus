require 'spec_helper'

describe 'taurus::_common' do
  context 'ubuntu' do
    let(:runner) { ChefSpec::SoloRunner.new(CHEFSPEC_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) { runner.converge(described_recipe) }

    included_recipes = %w(apt ark build-essential python)
    excluded_recipes = %w(yum-epel firewall)
    installed_package = [
      'python-dev',
      'python-pip',
      'python-virtualenv',
      'libxml2-dev',
      'libxslt1-dev',
      'zlib1g'
    ]
    omitted_package = %w(python-devel libxml2-devel libxslt-devel zlib)
    installed_python_pip = %w(lxml psutil pyzmq gevent)
    omitted_python_pip = %w(lxml2)

    included_recipes.each do |r|
      it "includes the recipe #{r}" do
        expect(chef_run).to include_recipe(r)
      end
    end

    excluded_recipes.each do |r|
      it "excludes the recipe #{r}" do
        expect(chef_run).to_not include_recipe(r)
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
