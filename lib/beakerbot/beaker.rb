module BeakerBot

  class Beaker

    def self.connect_machine(host_name, slave_name)
      cfg = Settings.instance().beaker

      ssh = Net::SSH.start(host_name, "#{cfg['username']}")
      ssh.exec!("yum -y install #{cfg['preinstalled_packages']}")
      ssh.exec!("svn co --non-interactive --trust-server-cert #{cfg['svn_repo']}")
      ssh.exec!("sed -i 's/$SLAVE_NAME/#{slave_name}/' ./#{cfg['init_script']}")
      ssh.exec!("chmod a+x ./#{cfg['init_script']}")
      ssh.exec!("./#{cfg['init_script']}")
      ssh.close
      
    end

  end

end
