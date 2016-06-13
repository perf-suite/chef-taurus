require 'spec_helper'

describe 'taurus::tsung' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: ['taurus']).converge('taurus::tsung')
  end
  it { expect(chef_run).to include_recipe('erlang') }

  it { expect(chef_run).to install_package('erlang') }

  it 'downloads tsung' do
    expect(chef_run).to install_with_make_ark('tsung')
  end
end
