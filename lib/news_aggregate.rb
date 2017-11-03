require 'http'
require 'yaml'
require 'json'
config = YAML::safe_load(File.read('config/secret.yml'))

# Tech news source
source = [
  'ars-technica',
  'engadget',
  'gruenderszene',
  'hacker-news',
  'recode',
  't3n',
  'techcrunc',
  'techradar',
  'the-next-web',
  'the-verge',
  'wired-de'
]

response = {}
result = {}

def newsSource(token, source)
	"https://newsapi.org/v1/articles?source="+source+"&sortBy=top&apiKey="+token
end

def call_url(url)
  HTTP.headers('Accept' => 'application/json').get(url)
end

path = newsSource(config,"techcrunch")

response = call_url(path)
result = JSON.parse(response)


File.write('../spec/fixtures/response.yml', response.to_yaml)
File.write('../spec/fixtures/result.yml', result.to_yaml)