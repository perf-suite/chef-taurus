source 'https://rubygems.org'

group :lint do
  gem 'foodcritic', '6.3.0'
  gem 'rubocop', '0.39.0'
end

group :unit do
  gem 'berkshelf', '4.3.5'
  gem 'fauxhai', '3.5.0'
  gem 'chefspec', '4.7.0'
  gem 'chef-sugar', '3.3.0'
  gem 'chef', '12.11.18'
  gem 'compat_resource', '12.10.6'
  gem 'rack', '1.6.4'
  gem 'listen', '3.0.8'
  gem 'berkshelf-api-client', '2.0.2'
end

group :kitchen_common do
  gem 'test-kitchen', '1.10.0'
end

group :kitchen_vagrant do
  gem 'kitchen-vagrant', '0.20.0'
end

group :kitchen_docker do
  gem 'docker'
  gem 'chef-provisioning-docker'
  gem 'kitchen-docker'
end

group :kitchen_cloud do
  gem 'kitchen-ec2', '1.0.0'
end

group :development do
  gem 'guard', '2.14.0'
  gem 'guard-kitchen'
  gem 'guard-foodcritic'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'rake', '11.3.0'
end
