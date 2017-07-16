module ActiveRecordFiles
  module Query
    module ClassMethods
      def find(record_id)
        collection = Collection.new(self)
        new(collection[record_id])
      end
    end
  end
end
