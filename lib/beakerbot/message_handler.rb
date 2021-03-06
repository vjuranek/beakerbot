module BeakerBot
  
  class MessageHandler
    @@impls = {}
    @reg_exp
    @help
    
    def self.register(type, reg_exp, help = "Sorry, no help available yet")
      @@impls[type] = self
      @reg_exp = reg_exp
      @help = help
    end
    
    def self.can_handle? message
      if @reg_exp =~ message
        return true
      end
      return false
    end

    def self.handle_message message
      @@impls.each_value do |handler|
        puts "Trying #{handler} for message #{message}"
        if handler.can_handle? message
          @handler = handler.new
          return @handler.handle message
        end
      end
      return error_reply
    end
    
    def self.error_reply
      return "Unknown command, type 'help' for listing available commands"
    end

    def self.get_help
      @help
    end

  end
  
end
  

