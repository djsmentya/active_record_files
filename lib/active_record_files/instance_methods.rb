module ActiveRecordFiles
  module InstanceMethods
    def save
      FileUtils.touch(build_path)
    end

    private

    def build_path
      Pathname.new(self.class.configurations[:root]) + "#{self.class.name.underscore.pluralize}.json"
    end
  end
end
