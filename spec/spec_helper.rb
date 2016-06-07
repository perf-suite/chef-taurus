require 'chefspec'
require 'chefspec/berkshelf'
require_relative './unit/support/matchers/ark_matchers'

at_exit { ChefSpec::Coverage.report! }

RSpec.configure do |config|
  config.platform = 'centos'
  config.version = '7.1.1503'
  config.order = 'random'
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end
