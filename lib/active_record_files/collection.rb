module ActiveRecordFiles
  class Collection
    attr_accessor :json_file

    delegate :[], :[]=, :to_json, :push, :length, to: :json_file

    def initialize(klass)
      @klass = klass
      @json_file = load_file(build_path(@klass))
    end

    def write
      File.write(build_path(@klass), @json_file.to_json)
    end

    protected

    def load_file(path)
      if File.file?(path)
        JSON.parse File.read(path)
      else
        File.open(path, 'w') { |io| io.write([].to_json) }
        []
      end
    end

    def build_path(klass)
      Pathname.new(klass.configurations[:root]) + "#{klass.name.underscore.pluralize}.json"
    end
  end
end
