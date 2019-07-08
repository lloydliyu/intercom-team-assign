require "sinatra"
require 'json'
require 'httparty'
require 'dotenv/load'
require_relative "assignment"

head "/webhook/" do
end

post "/webhook/" do
  # Check topic
  data = JSON.parse(request.body.read)
  if data['topic'] == 'conversation.admin.assigned'
    if data['data']['item']['conversation_parts']['conversation_parts'][0]['part_type'] == "away_mode_assignment"
      Assignment.new(data['data']['item']['id'])
    end
  elsif data['topic'] == 'ping'
    halt 200
  else
    halt 422
  end
end
