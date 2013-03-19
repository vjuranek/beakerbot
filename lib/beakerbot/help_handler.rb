module BeakerBot

  class HelpHandler < MessageHandler
    register(:help, /^help/)

    def handle message
      reply = "Known commands are: \n"
      @@impls.each_key do |cmd|
        reply += "#{cmd} \n" 
      end
      return reply
    end
   
  end
  
end
