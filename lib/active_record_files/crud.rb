module ActiveRecordFiles
  module CRUD
    module InstanceMethods
      def save
        build_record
        File.write(build_path, json_file.to_json)
        self
      end

      private

      def json_file
        @json_file
      end

      def build_record
        if new_record?
          json_file.push(attributes)
          @id = json_file.length - 1
        else
          json_file[id] = attributes
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
