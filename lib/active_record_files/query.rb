module ActiveRecordFiles
  module Query
    module ClassMethods
      def find(record_id)
        new(collection[record_id])
      end

      def where(attrs)
        result = []
        collection.json_file.each_with_index do |record, index|
          record_matched = attrs.all? { |key, val| record[key.to_s] == val }

          result.push(find(index)) if record_matched
        end
        result
      end

      protected

      def collection
        Collection.new(self)
      end
    end
  end
end
