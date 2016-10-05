require 'chefspec'
require 'chefspec/berkshelf'
require_relative './unit/support/matchers/ark_matchers'
# warn
LOG_LEVEL = :error
CENTOS_OPTS = {
  platform: 'centos',
  version: '7.2.1511',
  log_level: LOG_LEVEL
}.freeze
UBUNTU_OPTS = {
  platform: 'ubuntu',
  version: '16.04',
  log_level: LOG_LEVEL
}.freeze

CHEFSPEC_OPTS = UBUNTU_OPTS

RSpec.configure do |config|
  config.formatter = :documentation
  config.color = true
  config.log_level = :info
  config.platform = 'ubuntu'
  config.version = '16.04'
end

at_exit { ChefSpec::Coverage.report! }
