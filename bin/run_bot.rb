#!/usr/bin/env ruby

$LOAD_PATH.push File.dirname(__FILE__) + "/../lib"

require 'beakerbot'

# if(ARGV.size < 1)
#   config = File.dirname(__FILE__) + "../config/beakerbot.yaml"
# else
#   puts "Using #{ARGV[0]} as a config file"
#   config = ARGV[0]
# end

bot = BeakerBot::BeakerBot.new()
bot.start
