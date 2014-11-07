#!/usr/bin/env ruby
require "yaml"
require "twitter"
require "activesupport"

# config file
conf = YAML.load_file File.expand_path(".", "config.yml")

# image file
img = YAML.load_file File.expand_path(".", "config.yml")

# Twitter client configuration
client = Twitter::REST::Client.new do |config|
  config.consumer_key = conf['twitter']['consumer_key']
  config.consumer_secret = conf['twitter']['consumer_secret']
  config.access_token = conf['twitter']['access_token']
  config.access_token_secret = conf['twitter']['access_token_secret']
end

loop do
  sleep conf['sleep_time'].minutes
end