require 'spec_helper'

describe 'taurus::taurus' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: ['taurus']).converge('taurus::taurus')
  end

  it 'creates taurus group' do
    expect(chef_run).to create_group('taurus')
  end

  it 'creates taurus user' do
    expect(chef_run).to create_user('taurus')
  end

  it 'creates taurus directory' do
    expect(chef_run).to create_directory('/opt/taurus')
    expect(chef_run).to create_directory('/opt/taurus/.bzt')
  end

  it 'templates /opt/taurus/.bzt-rc' do
    expect(chef_run).to create_template('/opt/taurus/.bzt-rc')
  end

  it 'install python_pip bzt' do
    expect(chef_run).to install_python_pip 'bzt'
  end
end
