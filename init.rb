require 'json'
require 'httparty'
require 'dotenv/load'

data = {}

base_url = "https://api.intercom.io/"
headers = {"Authorization" => "Bearer " + ENV['IC_ACCESS_TOKEN'], "Accept" => "application/json"}
response = HTTParty.get(URI.encode(base_url + 'me'), :headers => headers)

data['workspace_id'] = response['app']['id_code']
data['assigner_id'] = response['id']
data['teams'] = []

response = HTTParty.get(URI.encode(base_url + 'teams'), :headers => headers)

response['teams'].each do | team |
  data['teams'] << team['id']
end

File.open("config.json","w") do |file|
    file.write data.to_json
end