require 'simplecov'
require 'rspec/fire'
require 'magus'

RSpec.configure do |config|
  config.include(RSpec::Fire)
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.mock_with :rspec do |c|
    c.syntax = :expect
  end
end

RSpec::Fire.configure do |config|
  config.verify_constant_names = true
end

Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |f| require f }

