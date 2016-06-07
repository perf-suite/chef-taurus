require 'spec_helper'

describe 'taurus::jmeter' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: ['taurus']).converge('taurus::jmeter')
  end
  it { expect(chef_run).to include_recipe('java') }

  # it { expect(chef_run).to install_package('openjdk-7-jdk') }

  it 'creates jmeter directory' do
    expect(chef_run).to create_directory('/opt/taurus/tools/jmeter')
  end

  it 'downloads jmeter-taurus' do
    expect(chef_run).to put_ark('jmeter')
  end

  it 'downloads jmeter libraries' do
    expect(chef_run).to put_ark('lib')
  end

  it 'sets bin/jmeter perms to 755' do
    expect(chef_run).to create_file('/opt/taurus/tools/jmeter/bin/jmeter').with(
      mode: '0755'
    )
  end
  it 'sets bin/jmeter-server perms to 755' do
    expect(chef_run).to create_file('/opt/taurus/tools/jmeter/bin/jmeter-server').with(
      mode: '0755'
    )
  end
  it 'sets bin/ApacheJMeter.jar perms to 755' do
    expect(chef_run).to create_file('/opt/taurus/tools/jmeter/bin/ApacheJMeter.jar').with(
      mode: '0755'
    )
  end
end
