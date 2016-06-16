require 'spec_helper'

describe 'taurus::ab' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: ['taurus']).converge('taurus::ab')
  end
  it { expect(chef_run).to install_package('httpd-tools') }
end
