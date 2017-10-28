require './init.rb'
require 'rack/test'

include Rack::Test::Methods

def app
  NewsPraise::Api
end