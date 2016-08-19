require 'spec_helper'

describe 'taurus::locustio' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: ['taurus']).converge('taurus::locustio')
  end

  it 'install python_pip locustio' do
    expect(chef_run).to install_python_pip 'locustio'
  end

  it 'templates /opt/taurus/taurus_locustfile.py' do
    expect(chef_run).not_to create_template('/opt/taurus/taurus_locustfile.py')
  end

  it 'does not create locustio-service directory' do
    expect(chef_run).not_to create_directory('/var/log/locustio-service')
  end

  it 'does not create runit_service[locustio-service]' do
    expect(chef_run).not_to enable_runit_service('locustio-service')
  end
end
