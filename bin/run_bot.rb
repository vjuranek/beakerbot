#!/usr/bin/env ruby

$LOAD_PATH.push File.dirname(__FILE__) + "/../lib"

require 'beakerbot'

bot = BeakerBot::BeakerBot.new 
bot.start
