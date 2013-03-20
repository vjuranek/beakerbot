module BeakerBot

  class HelpHandler < MessageHandler
    register(:help, /^help/)

    def handle message
      message.strip!
      if message =~ /^help$/
        return all_cmds_reply
      elsif message =~ /^help #{all_cmds_regexp}$/
        return get_help_for message.split[1]
      else
        return "Unkhown command '#{message.split[1]}', type 'help' to list available commands"
      end
    end

    def all_cmds_reply
      reply = "Known commands are: \n"
      @@impls.each_key do |cmd|
        reply += "#{cmd} \n" 
      end
      return reply
    end

    def get_help_for(cmd)
      reply = "Help for command '#{cmd}': \n"
      reply += @@impls[cmd.to_sym].get_help
      return reply
    end

    def all_cmds_regexp
      regexp = "("
      @@impls.each_key do |cmd|
        regexp += "#{cmd}|" 
      end
      regexp = regexp[0..-2]
      regexp += ")"
      return regexp.to_sym
    end

  end
  
end
