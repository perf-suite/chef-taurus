require 'spec_helper'

describe 'taurus::gatling' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: ['taurus']).converge('taurus::gatling')
  end
  it { expect(chef_run).to include_recipe('java') }

  # it { expect(chef_run).to install_package('openjdk-7-jdk') }

  it 'creates gatling directory' do
    expect(chef_run).to create_directory('/opt/taurus/tools/gatling')
  end

  it 'downloads gatling' do
    expect(chef_run).to put_ark('gatling')
  end

  it 'sets bin/gatling.sh perms to 755' do
    expect(chef_run).to create_file('/opt/taurus/tools/gatling/bin/gatling.sh').with(
      mode: '0755'
    )
  end
  it 'sets bin/recorder.sh perms to 755' do
    expect(chef_run).to create_file('/opt/taurus/tools/gatling/bin/recorder.sh').with(
      mode: '0755'
    )
  end
end
