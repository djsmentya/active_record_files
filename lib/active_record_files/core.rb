module ActiveRecordFiles
  module Core
    @@configurations = {}

    def configurations=(config)
      @@configurations = config
    end

    def configurations
      @@configurations
    end
  end
end
