require_relative 'core'
require_relative 'crud'
require_relative 'attributes'
require_relative 'persistence'
require_relative 'errors/no_root_folder_error'

module ActiveRecordFiles
  class Base
    extend Core
    extend CRUD::ClassMethods
    extend Attributes::ClassMethods

    include Attributes::InstanceMethods
    include CRUD::InstanceMethods
    include Persistence

    def initialize(args={})
      raise ActiveRecordFiles::NoRootFolderError if self.class.configurations[:root].nil?
      @json_file = load_file
      load_schema!(args)
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
