module BeakerBot
  
  class BeakerHandler < MessageHandler
    register(:beaker, /^beaker/)
    
    def self.handle message
      return "Beaker handler, handling message #{message}"
    end
   
  end
  
end
