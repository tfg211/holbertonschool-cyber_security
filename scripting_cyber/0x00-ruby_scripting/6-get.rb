require 'net/http'
require 'json'
require 'uri'

def get_request(url)
  uri = URI(url)

  response = Net::HTTP.get_response(uri)

  puts "Response status: #{response.code} #{response.message}"
  puts "Response body:"

  json = JSON.parse(response.body)
  puts JSON.pretty_generate(json)
end
