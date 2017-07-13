require_relative 'core'
require_relative 'instance_methods'
require_relative 'class_methods'

module ActiveRecordFiles
  class Base
    extend Core
    extend ClassMethods

    include InstanceMethods
  end
end
