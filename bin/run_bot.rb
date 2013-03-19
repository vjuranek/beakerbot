#!/usr/bin/env ruby

$LOAD_PATH.push File.dirname(__FILE__) + "/../lib"

require 'beakerbot'

# mh = BeakerBot::MessageHandler.new
# puts mh.handle_message "ssh test"
# puts mh.handle_message "beaker test"
# puts mh.handle_message "sdsds"

bot = BeakerBot::BeakerBot.new 
bot.start
