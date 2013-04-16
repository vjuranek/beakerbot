module BeakerBot
  
  class JenkinsHandler < MessageHandler
    register(:jenkins, /^jenkins/)

    def handle message

      case message
      when /^jenkins\sconnect\s([\w\d\.]+)\sas\s(.+)$/ =~ message
        hostname = $1
        slave_name = $2
        return connect_slave(hostname, slave_name)
      else
        return "#{message} doesn't seem to be valid request, syntax is #{self.class.get_syntax}"
      end

    end

    def connect_slave(hostname, slave_name)
      cfg = Settings.instance().jenkins
      reply = "Connecting '#{hostname}' as '#{slave_name}' ... \n"
      begin
        Beaker.connect_machine(hostname, slave_name)
      rescue Exception => err
        reply += "Somethig went wrong: #{err}"
        return reply
      end
      reply += "[OK]"
      reply += "Check #{cfg['server']}/computer/#{slave_name}/"

      return reply
    end

    def self.get_syntax
      return "jenkins connect [hostname] as [slave_name]"
    end

    def self.get_help
      return "Run '#{self.get_syntax}' to connect machine as a Jenkins slave"
    end
   
  end
  
end
