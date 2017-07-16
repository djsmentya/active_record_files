module ActiveRecordFiles
  module Attributes

    module InstanceMethods
      attr_reader :attributes

      # Define setter for attributes
      def load_schema!(args)
        define_attributes
        assign_attributes(args)
      end


      protected

      def assign_attributes(attrs)
        attrs.each do |name, value|
          send("#{name}=", value)
        end
      end

      def define_attributes
        @attributes = {}
        self.class.attributes_to_define.each do |name, _type|
          self.class.class_eval do
            define_method "#{name}=" do |value|
              @attributes[name] = value
            end

            define_method name do
              @attributes[name]
            end
          end
        end
      end
    end

    module ClassMethods

      @@attributes_to_define = {}

      def attributes_to_define=(attrs)
        @@attributes_to_define = attrs
      end

      def attributes_to_define
        @@attributes_to_define
      end

      # map attributes for json document
      def attribute(name, type)
        attributes_to_define[name] = type
      end
    end
  end
end
