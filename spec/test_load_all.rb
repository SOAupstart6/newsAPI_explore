require './init.rb'
require 'rack/test'

include Rack::Test::Methods

def app
  NewsCollect::Api
end