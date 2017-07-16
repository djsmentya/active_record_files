require_relative 'collection'

require_relative 'core'
require_relative 'crud'
require_relative 'attributes'
require_relative 'persistence'
require_relative 'query'

require_relative 'errors/no_root_folder_error'

module ActiveRecordFiles
  class Base
    extend Core
    extend CRUD::ClassMethods
    extend Attributes::ClassMethods
    extend Query::ClassMethods

    include Attributes::InstanceMethods
    include CRUD::InstanceMethods
    include Persistence

    def initialize(args = {} )
      raise ActiveRecordFiles::NoRootFolderError if self.class.configurations[:root].nil?
      load_schema!(args)
    end
  end
end
