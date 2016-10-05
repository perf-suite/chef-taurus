require 'spec_helper'

describe 'taurus::locustio' do
  context 'centos' do
    let(:runner) { ChefSpec::SoloRunner.new(CENTOS_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) { runner.converge(described_recipe) }

    installed_python_pip = %w(locustio)
    omitted_python_pip = %w(locust)

    it 'does not create templates /opt/taurus/taurus_locustfile.py' do
      expect(chef_run).not_to create_template('/opt/taurus/taurus_locustfile.py')
    end

    it 'does not render /opt/taurus/taurus_locustfile.py with content' do
      expect(chef_run).not_to render_file('/opt/taurus/taurus_locustfile.py').with_content { |content|
        expect(content).to match(/from locust import HttpLocust, TaskSet, task/)
        expect(content).to match(/class MyTaskSet(TaskSet):/)
        expect(content).to match(/class MyLocust(HttpLocust):/)
      }
    end

    it 'does not create templates /etc/service/locustio-service/control/d' do
      expect(chef_run).not_to create_template('/etc/service/locustio-service/control/d')
    end

    it 'does not render /etc/service/locustio-service/control/d with content' do
      expect(chef_run).not_to render_file('/etc/service/locustio-service/control/d').with_content('pkill -f \'locust.*logfile=.*log$\'')
    end

    it 'does not create locustio-service directory' do
      expect(chef_run).not_to create_directory('/var/log/locustio-service')
    end

    it 'does not create runit_service[locustio-service]' do
      expect(chef_run).not_to enable_runit_service('locustio-service')
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
