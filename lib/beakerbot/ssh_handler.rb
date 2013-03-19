require 'net/ssh'

module BeakerBot
  
  class SshHandler < MessageHandler
    register(:ssh, /^ssh/)

    def self.handle message
      return "Ssh handler, handling message #{message}"
    end
   
  end
  
end
