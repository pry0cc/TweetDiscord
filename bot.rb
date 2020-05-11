#!/usr/bin/env ruby
require "discordrb"
require "twitter"

bot = Discordrb::Commands::CommandBot.new(token: ENV["discord"], prefix: "!")

client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV["pk"]
  config.consumer_secret = ENV["ps"]
  config.access_token = ENV["atp"]
  config.access_token_secret = ENV["ats"]
end

bot.set_role_permission(ENV["group"].to_i, 10)

bot.command(:tweet, permission_level: 10) do |event, *args|
  begin
    client.update(args.join(" "))
  rescue Exception => e
    return "Error occured! Sorry!"
  else
    return "Tweet posted!"
  end
end

bot.run
