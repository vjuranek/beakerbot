require 'net/ssh'

module BeakerBot
  
  class SshHandler < MessageHandler
    register(:ssh, /^ssh/)

    def handle message
      if not /^ssh exec\s(\w+)\son\s(.*)\sas\s(\w+)$/ =~ message
        return "#{message} doesn't seem to be valid request, syntax is #{self.class.get_syntax}"
      end

      command = $1
      hostname = $2
      username = $3
      reply = "Executing '#{command}' on host '#{hostname}' as a user '#{username}' ... \n"

      begin
        ssh = Net::SSH.start(hostname, username)
        reply += ssh.exec!(command)
        ssh.close
      rescue Exception => err
        reply += "Somethig went wrong: #{err}"
      end

      return reply
    end

    def self.get_syntax
      return "ssh exec [ssh commnd] on [host] as [user]"
    end

    def self.get_help
      return "Run '#{self.get_syntax}' to execute ssh command on given host"
    end
   
  end
  
end
