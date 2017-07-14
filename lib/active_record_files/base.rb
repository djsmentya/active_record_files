require_relative 'core'
require_relative 'instance_methods'
require_relative 'class_methods'

module ActiveRecordFiles
  class Base
    extend Core
    extend ClassMethods

    include InstanceMethods

    def initialize
      @json_file = load_file
    end

    private

    def load_file
      path = build_path
      if File.file?(path)
        JSON.parse File.read(path)
      else
        File.open(path, 'w') { |io| io.write([].to_json) }
        []
      end
    end

    def build_path
      Pathname.new(self.class.configurations[:root]) + "#{self.class.name.underscore.pluralize}.json"
    end
  end
end
