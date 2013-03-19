require 'cinch'

module BeakerBot
  
  class BeakerBot < Cinch::Bot

    SERVER = "irc.devel.redhat.com"
    CHANNEL = "#jenkins"
    NICK = "beakerbot"
    
    def initialize
      super

      configure do |c|
        c.server = SERVER
        c.channels = [CHANNEL]
        c.nick     = NICK
      end

      on :message, /^(#{NICK}|#{NICK}:) (.+)/ do |m, nick, message|
        m.reply MessageHandler.handle_message(message)
      end

    end

  end

end
