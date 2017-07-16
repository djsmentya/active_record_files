module ActiveRecordFiles
  module CRUD
    module InstanceMethods
      def save
        build_record
        collection.write
        self
      end

      private

      def collection
        @collection ||= Collection.new(self.class)
      end

      def build_record
        if new_record?
          collection.push(attributes)
          @id = collection.length - 1
        else
          collection[id] = attributes
        end
      end
    end

    module ClassMethods
      def create(args)
        object = new(args)
        object.save
      end
    end
  end
end
