module ActiveRecordFiles
  module ClassMethods
    def create
      object = new
      object.save
    end
  end
end
