ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative 'test_load_all'

VCR.configure do |c|
  c.cassette_library_dir = CASSETTES_FOLDER
  c.hook_into :webmock

  api_token = app.config.token
  c.filter_sensitive_data('<API_TOKEN>') { api_token }
  c.filter_sensitive_data('<API_TOKEN_ESC>') { CGI.escape(api_token) }
end