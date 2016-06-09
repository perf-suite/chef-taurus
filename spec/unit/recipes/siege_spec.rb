require 'spec_helper'

describe 'taurus::siege' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: ['taurus']).converge('taurus::siege')
  end
  it { expect(chef_run).to install_package('siege') }
end
