require 'spec_helper'

describe 'taurus::default' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: ['taurus']).converge('taurus::default')
  end
  it { expect(chef_run).to include_recipe('taurus::_common') }
  it { expect(chef_run).to include_recipe('taurus::taurus') }
  it { expect(chef_run).to include_recipe('taurus::jmeter') }
  it { expect(chef_run).to include_recipe('taurus::locustio') }
  it { expect(chef_run).to include_recipe('taurus::ab') }
  it { expect(chef_run).to include_recipe('taurus::siege') }
  it { expect(chef_run).to include_recipe('taurus::gatling') }
  it { expect(chef_run).to include_recipe('taurus::tsung') }
end
