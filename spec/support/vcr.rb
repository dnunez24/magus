require 'vcr'
require File.expand_path('../api_helpers.rb', __FILE__)
include ApiHelpers

def filters
  file = File.expand_path("../../../filters.yml", __FILE__)
  YAML.load_file(file) if File.exists?(file)
end

VCR.configure do |config|
  config.cassette_library_dir = File.expand_path('../../cassettes', __FILE__)
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.default_cassette_options = {
    :record => :once,
    :match_requests_on => [:method, :uri, :body],
    :erb => true
  }

  config.after_http_request(:recordable?) do |request, response|
    last_response = response
  end

  credentials.each_pair do |api, creds|
    creds.each_pair do |key, value|
      config.filter_sensitive_data("$$#{key.upcase}$$") { value }
      config.before_record do |interaction|
        interaction.filter!(value, "$$#{key.upcase}$$")
      end
    end
  end

  if filters
    filters.each_pair do |value, replacement|
      config.filter_sensitive_data(replacement) { value }
      config.before_record do |interaction|
        interaction.filter!(value, replacement)
      end
    end
  end
end
