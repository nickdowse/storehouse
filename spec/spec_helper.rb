# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper.rb"` to ensure that it is only
# loaded once.
#

rails_version = ENV['RAILS_VERSION'] || 2
ENV['rails_version_for_test_suite'] = (rails_version == 2 ? '2.3.14' : '3.2')
require "mockery#{rails_version}/config/#{rails_version == 2 ? 'environment' : 'application'}.rb"


def get_storehouse_middleware
  Rails.configuration.middleware.select{|m| m.klass.name =~ /Storehouse/}.first
end

def use_middleware_adapter!(name, options = {})
  mid = get_storehouse_middleware
  mid.args[0] = name
  mid.args[1] = options
end


# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end
