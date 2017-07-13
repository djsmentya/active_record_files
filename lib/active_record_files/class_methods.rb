module ActiveRecordFiles
  module ClassMethods
    def create
      object = new
      object.save
      object
    end
  end
end
