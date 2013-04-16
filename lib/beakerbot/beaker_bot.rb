require 'cinch'

module BeakerBot
  
  class BeakerBot < Cinch::Bot

    def initialize
      super
      
      cfg = Settings.instance().global
      configure do |c|
        c.server = cfg['server']
        c.channels = cfg['channels']
        c.nick = cfg['nick']
      end

      on :message, /^(#{cfg['nick']}|#{cfg['nick']}:) (.+)/ do |m, nick, message|
        m.reply MessageHandler.handle_message(message)
      end

    end

  end

end
