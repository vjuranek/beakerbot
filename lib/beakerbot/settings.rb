require 'singleton'
require 'yaml'

module BeakerBot
  
  class Settings 
    include Singleton
    
    def initialize()
      # TODO provide possibility to configure the config path
      @config = YAML.load_file(File.dirname(__FILE__) + "/../../config/beakerbot.yaml")
    end
    
    def global
      @config['global']
    end
    
    def jenkins
      @config['jenkins']
    end

    def beaker
      @config['beaker']
    end

  end

end
