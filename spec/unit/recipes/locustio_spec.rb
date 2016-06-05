require 'spec_helper'

describe 'taurus::locustio' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: ['taurus']).converge('taurus::locustio')
  end

  it 'install python_pip locustio' do
    expect(chef_run).to install_python_pip 'locustio'
  end
end
