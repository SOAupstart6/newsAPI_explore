ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative 'test_load_all'

USERNAME = 'soumyaray'.freeze
REPO_NAME = 'YPBT-app'.freeze
CASSETTES_FOLDER = 'spec/fixtures/cassettes'.freeze

VCR.configure do |c|
  c.cassette_library_dir = CASSETTES_FOLDER
  c.hook_into :webmock

  github_token = app.config.gh_token
  c.filter_sensitive_data('<GITHUB_TOKEN>') { github_token }
  c.filter_sensitive_data('<GITHUB_TOKEN_ESC>') { CGI.escape(github_token) }
end