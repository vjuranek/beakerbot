require 'net/scp'

module BeakerBot
  
  class ScpHandler < MessageHandler
    register(:scp, /^scp/)

    def handle message
      if not /^scp\s(.+)\sto\s([\w\d\.]+):(.+)\sas\s(\w+)$/ =~ message
        return "#{message} doesn't seem to be valid request, syntax is #{self.class.get_syntax}"
      end

      local_file = $1
      hostname = $2
      remote_file = $3
      username = $4

      if not File.exists? local_file
        return "Local file '#{local_file}' doesn't seem to exist!"
      end

      reply = "Copying '#{local_file}' to host '#{hostname}' to '#{remote_file}' as '#{username}' ... \n"
      begin
        scp = Net::SCP.start(hostname, username)
        scp.upload!(local_file, remote_file)
      rescue Exception => err
        reply += "Somethig went wrong: #{err}"
      end
      reply += "[OK]"

      return reply
    end

    def self.get_syntax
      return "scp [local_file] to [host:remote_file] as [username]"
    end

    def self.get_help
      return "Run '#{self.get_syntax}' to scp file to given host"
    end
   
  end
  
end
