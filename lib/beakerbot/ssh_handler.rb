module BeakerBot
  
  class SshHandler < MessageHandler
    register(:ssh, /^ssh/)

    def initialize
      puts "SSH created!"
    end
    
    def self.handle message
      return "Ssh handler, handling message #{message}"
    end
   
  end
  
end
