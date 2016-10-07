# encoding: UTF-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

# https://gist.githubusercontent.com/zuazo/650eda19dc88a4eb91d4/raw/773c346915f0b88687e6ed58286a46c8b5d8c91f/Chef-Rakefile.rb

require 'bundler/setup'

def ci?
  ENV['CI'] == 'true'
end

desc 'Clean some generated files'
task :clean do
  %w(
    Berksfile.lock
    .bundle
    .cache
    coverage
    Gemfile.lock
    .kitchen
    metadata.json
    vendor
  ).each { |f| FileUtils.rm_rf(Dir.glob(f)) }
end

desc 'Generate Ruby documentation using yard'
task :yard do
  require 'yard'
  YARD::Rake::YardocTask.new do |t|
    t.stats_options = %w(--list-undoc)
  end
end

desc 'Generate Ruby documentation'
task doc: %w(yard)

namespace :style do
  require 'rubocop/rake_task'
  desc 'Run Ruby style checks using rubocop'
  RuboCop::RakeTask.new(:ruby)

  require 'foodcritic'
  desc 'Run Chef style checks using foodcritic'
  FoodCritic::Rake::LintTask.new(:chef)
end

desc 'Run all style checks'
task style: %w(style:chef style:ruby)

desc 'Run ChefSpec unit tests'
task :unit do
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.rspec_opts = '--color --format progress'
    t.pattern = 'spec/unit/**{,/*/**}/*_spec.rb'
  end
end

desc 'Run Test Kitchen integration tests'
namespace :integration do
  # Gets a collection of instances.
  #
  # @param regexp [String] regular expression to match against instance names.
  # @param config [Hash] configuration values for the `Kitchen::Config` class.
  # @return [Collection<Instance>] all instances.
  def kitchen_instances(regexp, config)
    instances = Kitchen::Config.new(config).instances
    return instances if regexp.nil? || regexp == 'all'
    instances.get_all(Regexp.new(regexp))
  end

  # Runs a test kitchen action against some instances.
  #
  # @param action [String] kitchen action to run (defaults to `'test'`).
  # @param regexp [String] regular expression to match against instance names.
  # @param loader_config [Hash] loader configuration options.
  # @return void
  def run_kitchen(action, regexp, loader_config = {})
    action = 'test' if action.nil?
    require 'kitchen'
    Kitchen.logger = Kitchen.default_file_logger
    config = { loader: Kitchen::Loader::YAML.new(loader_config) }
    kitchen_instances(regexp, config).each { |i| i.send(action) }
  end

  desc 'Run Test Kitchen integration tests using vagrant'
  task :vagrant, [:regexp, :action] do |_t, args|
    run_kitchen(args.action, args.regexp)
  end

  desc 'Run Test Kitchen integration tests using docker'
  task :docker, [:regexp, :action] do |_t, args|
    run_kitchen(args.action, args.regexp, local_config: '.kitchen.docker.yml')
  end

  desc 'Run Test Kitchen integration tests in the cloud'
  task :cloud, [:regexp, :action] do |_t, args|
    run_kitchen(args.action, args.regexp, local_config: '.kitchen.cloud.yml')
  end
end

desc 'Run Test Kitchen integration tests'
task :integration, [:regexp, :action] =>
  ci? ? %w(integration:docker) : %w(integration:vagrant)

desc 'Run doc, style, unit and integration tests'
task default: %w(style unit integration:vagrant)
task docker: %w(style unit integration:docker)
task ci: %w(style unit) 
