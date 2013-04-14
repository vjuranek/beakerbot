require 'singleton'
require 'yaml'

module BeakerBot
  
  class Settings 
    include Singleton
    
    def initialize()
      # TODO provide possibility to configure the config path
      @config = YAML.load_file(File.dirname(__FILE__) + "/../../config/beakerbot.yaml")
    end
    
    def server
      @config['server']
    end

    def channels
      @config['channels']
    end

    def nick
      @config['nick']
    end

  end

end
