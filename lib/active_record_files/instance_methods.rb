module ActiveRecordFiles
  module InstanceMethods
    def save
      build_record
      File.write(build_path, json_file.to_json)
    end

    private

    def json_file
      @json_file
    end

    def build_record
      json_file.push(attributes)
    end
  end
end
