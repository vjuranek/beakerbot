module BeakerBot
  
  class JenkinsHandler < MessageHandler
    register(:jenkins, /^jenkins/)

    def handle message
      if not /^jenkins\sconnect\s([\w\d\.]+)\sas\s(.+)$/ =~ message
        return "#{message} doesn't seem to be valid request, syntax is #{self.class.get_syntax}"
      end

      hostname = $1
      slave_name = $2

      reply = "Connecting '#{hostname}' as '#{slave_name}' ... \n"
      begin
        ssh = Net::SSH.start(hostname, "root")
        ssh.exec!("yum -y install subversion")
        ssh.exec!("svn co --non-interactive --trust-server-cert https://svn.devel.redhat.com/repos/jboss-qa/hudson/config_repository/tools/rhts")
        ssh.exec!("sed -i 's/$SLAVE_NAME/#{slave_name}/' ./rhts/prepare.sh")
        ssh.exec!("chmod a+x ./rhts/prepare.sh")
        ssh.exec!("./rhts/prepare.sh")
        ssh.close
      rescue Exception => err
        reply += "Somethig went wrong: #{err}"
      end
      reply += "[OK]"
      reply += "Check https://jenkins.mw.lab.eng.bos.redhat.com/hudson/computer/#{slave_name}/"

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
