#!/usr/bin/env ruby

require 'bundler'
Bundler.require

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['CONSUMER_KEY']
  config.consumer_secret = ENV['CONSUMER_SECRET']
  config.access_token = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

COLORS = [
  "black",
  "red",
  "green",
  "yellow",
  "blue",
  "magenta",
  "cyan",
  "white",
]

tweets = []
client.search("#ggjsap -RT", result_type: 'resent').take(256).each do |tweet|
  tweets << tweet.text.length
end
img = Magick::Image.new(16, 16) { self.background_color = 'white' }
tweets.each_with_index {|t, i| img.pixel_color(i - 16 < 0 ? i : i + 1 - ((i + 1) / 16) * 16, (i + 1) / 16 , COLORS[t % 8]) }
img.write('result.bmp')
