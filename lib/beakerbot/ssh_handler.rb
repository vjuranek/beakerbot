require 'net/ssh'

module BeakerBot
  
  class SshHandler < MessageHandler
    register(:ssh, /^ssh/)

    def handle message
      return "Ssh handler, handling message #{message}"
    end

    def self.get_help
      return "Run 'ssh exec [ssh commnd] on [host]' to execute ssh command on given host"
    end
   
  end
  
end
