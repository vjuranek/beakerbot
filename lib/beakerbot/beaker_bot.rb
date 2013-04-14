require 'cinch'

module BeakerBot
  
  class BeakerBot < Cinch::Bot

    def initialize()
      super
      
      cfg = Settings.instance()
      puts "Connecting to #{cfg.server} #{cfg.channels} as #{cfg.nick}"
      configure do |c|
        c.server = cfg.server
        c.channels = cfg.channels
        c.nick = cfg.nick
      end

      on :message, /^(#{NICK}|#{NICK}:) (.+)/ do |m, nick, message|
        m.reply MessageHandler.handle_message(message)
      end

    end

  end

end
