require_relative 'core'
require_relative 'instance_methods'
require_relative 'class_methods'
require_relative 'model_schema'
require_relative 'errors/no_root_folder_error'

module ActiveRecordFiles
  class Base
    extend Core
    extend ClassMethods
    extend ModelSchema::ClassMethods

    include ModelSchema::InstanceMethods
    include InstanceMethods

    def initialize
      raise ActiveRecordFiles::NoRootFolderError if self.class.configurations[:root].nil?
      @json_file = load_file
      load_schema!
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
