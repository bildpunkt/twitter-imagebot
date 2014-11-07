#!/usr/bin/env ruby
require "yaml"
require "twitter"
require "activesupport"

# config file
conf = YAML.load_file File.expand_path(".", "config.yml")

# image file
img = YAML.load_file File.expand_path(".", "images.yml")

# Twitter client configuration
client = Twitter::REST::Client.new do |config|
  config.consumer_key = conf['twitter']['consumer_key']
  config.consumer_secret = conf['twitter']['consumer_secret']
  config.access_token = conf['twitter']['access_token']
  config.access_token_secret = conf['twitter']['access_token_secret']
end

loop do
  begin
    post_img = img.sample
    if File.exists? File.expand_path("../#{conf['image_directory']}#{post_img['location']}", __FILE__)
      client.update_with_media "#{post_img['name']} | #{post_img['source']}", File.new("#{conf['image_directory']}#{post_img['location']}")
    else
      puts "[#{time.new.to_s}] No image for #{post_img['location']} found!"
    end
  rescue Exception => e
    puts "[#{time.new.to_s}] #{e.message}"
  end
  sleep conf['sleep_time'].minutes
end