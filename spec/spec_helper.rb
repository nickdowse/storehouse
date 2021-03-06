# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration


require 'storehouse'
require 'active_support/core_ext/hash/reverse_merge'
require 'active_support/core_ext/array/extract_options'

begin
  require 'ruby-debug'
rescue LoadError => e
  nil
end

begin
  require 'debugger'
rescue LoadError => e
  nil
end

ROOT = ENV['STOREHOUSE_ROOT'] = File.join(File.dirname(__FILE__), 'test_app')

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.before :each do
    gem_config(:simple)
    Storehouse.clear!
  end

  Storehouse.class_eval do
    class << self
      def set_spec(spec)
        @store = nil
        @spec = spec
      end
    end
  end

  # gem_config :namespace, :distribute, :type => :redis
  def gem_config(*names)
    options = names.extract_options!
    options[:type] ||= :memory
    config = {}
    names << :simple if names.empty?
    names.each{|n| config.merge!(send("#{n}_config")) }
    config.merge!(send("#{options[:type]}_config"))
    Storehouse.set_spec(config)
  end

  def simple_config
    {
      'enabled' => true
    }
  end

  def disabled_config
    {
      'enabled' => false
    }
  end

  def namespace_config
    simple_config.merge!({
      'namespace' => 'test'
    })
  end

  def distribute_config
    simple_config.merge!({
      'distribute' => true
    })
  end

  def postpone_config
    simple_config.merge!({
      'postpone' => true
    })
  end

  def panic_config
    simple_config.merge!({
      'panic_path' => 'tmp/panic.txt'
    })
  end

  def reheat_config
    simple_config.merge!({
      'reheat_param' => 'reheat_cache'
    })
  end

  def ignore_config
    simple_config.merge!({
      'ignore_params' => true
    })
  end

  def bot_config
    simple_config.merge!({
      'serve_expired_content_to' => 'Bot'
    })
  end

  def timeout_config
    simple_config.merge!({
      'timeouts' => {
        'key_expiration' => 3600 * 24,
        'read' => 0.2,
        'write' => 0.2
      }
    })
  end

  def redis_config
    {
      'backend' => 'redis',
      'connections' => {
        'host' => '127.0.0.1',
        'port' => 6379
      }
    }
  end

  def riak_config
    {
      'backend' => 'riak',
      'connections' => {
        :host => '127.0.0.1',
        :http_port => 8098
      }
    }
  end

  def memory_config
    {
      'backend' => 'memory', 
      'connections' => {}
    }
  end

  def subdomain_config
    simple_config.merge!({
      'subdomains' => %w(a b c)
    })
  end
end
