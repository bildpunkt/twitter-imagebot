#!/usr/bin/env ruby
require "yaml"
require "twitter"

# version
version = "v1.1.0"

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

last_img = ""
reroll = false

# Generic text output
puts "\033[34;1mtwitter-imagebot #{version}\033[0m by pixeldesu"
puts "running on @#{client.user.screen_name} hosted by @#{conf['username']}"
puts "----------------------------------------"

# The loop the bots code is running in, do NOT touch this unless you know what to do
loop do
  begin
    post_img = img.sample
    if last_img != post_img['location']
      if File.exists? File.expand_path("../#{conf['image_directory']}#{post_img['location']}", __FILE__)
        client.update_with_media "#{post_img['name']} | #{post_img['source']}", File.new("#{conf['image_directory']}#{post_img['location']}")
        puts "\033[32;1m[#{Time.new.to_s}] Successfully posted image '#{post_img['name']}'\033[0m"
        last_img = post_img['location']
      else
        puts "\033[31;1m[#{Time.new.to_s}] No image for #{post_img['name']} found!\033[0m"
      end
    else
      puts "\033[31;1m[#{Time.new.to_s}] Generated '#{post_img['name']}' again. Re-rolling!"
      reroll = true
    end
  rescue Exception => e
    puts "\033[31;1m[#{Time.new.to_s}] #{e.message}\033[0m"
  end
  if reroll
    sleep 1
    reroll = false
  else
    sleep conf['sleep_time'].to_i * 60
  end
end
