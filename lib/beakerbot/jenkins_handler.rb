module BeakerBot
  
  class JenkinsHandler < MessageHandler
    register(:jenkins, /^jenkins/)

    def handle message
      if not /^jenkins\sconnect\s([\w\d\.]+)\sas\s(.+)$/ =~ message
        return "#{message} doesn't seem to be valid request, syntax is #{self.class.get_syntax}"
      end

      hostname = $1
      slave_name = $2

      cfg_j = Settings.instance().jenkins
      cfg_b = Settings.instance().beaker

      reply = "Connecting '#{hostname}' as '#{slave_name}' ... \n"
      begin
        ssh = Net::SSH.start(hostname, "#{cfg_b['username']}")
        ssh.exec!("yum -y install #{cfg_b['preinstalled_packages']}")
        ssh.exec!("svn co --non-interactive --trust-server-cert #{cfg_b['svn_repo']}")
        ssh.exec!("sed -i 's/$SLAVE_NAME/#{slave_name}/' ./#{cfg_b['init_script']}")
        ssh.exec!("chmod a+x ./#{cfg_b['init_script']}")
        ssh.exec!("./#{cfg_b['init_script']}")
        ssh.close
      rescue Exception => err
        reply += "Somethig went wrong: #{err}"
      end
      reply += "[OK]"
      reply += "Check #{cfg_j['server']}/computer/#{slave_name}/"

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
