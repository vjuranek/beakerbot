# Dir.glob(File.dirname(__FILE__) + "/beakerbot/*.rb") do |file|
#   require file
# end

require "beakerbot/beaker_bot.rb"
require "beakerbot/message_handler.rb"
require "beakerbot/beaker_handler.rb"
require "beakerbot/help_handler.rb"
require "beakerbot/jenkins_handler.rb"
require "beakerbot/scp_handler.rb"
require "beakerbot/settings.rb"
require "beakerbot/ssh_handler.rb"
