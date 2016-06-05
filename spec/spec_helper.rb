require 'chefspec'
require 'chefspec/berkshelf'
require_relative './unit/support/matchers/ark_matchers'

at_exit { ChefSpec::Coverage.report! }
