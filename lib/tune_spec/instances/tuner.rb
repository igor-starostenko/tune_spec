# frozen_string_literal: true

module TuneSpec
  module Instances
    # Abstract class for Group, Step and Page
    class Tuner
      def self.create_instance_method(name)
        method_name = instance_method_name(name)
        return if respond_to?(method_name)
        define_singleton_method(method_name) do |*args|
          var_name = instance_variable_name(name)
          instance_var = instance_variable_get(var_name)
          return instance_var if rules_passed?(instance_var, args)
          new_instance = call_object(method_name).new(*args)
          instance_variable_set(var_name, new_instance)
        end
      end

      def self.call_instance_method(name, *args, block)
        method_name = instance_method_name(name)
        formatted_args = prepare_args(args, call_object(method_name))
        return __send__(method_name, *formatted_args) unless block
        __send__(method_name, *formatted_args).instance_eval(&block)
      end

      class << self
        private

        def instance_variable_name(name)
          "@#{instance_method_name(name)}"
        end

        def instance_method_name(name)
          "#{name}_#{type}".downcase
        end

        def type
          @type ||= itself.to_s.split('::').last.downcase
        end

        # A hook to define rules by subclasses
        def rules_passed?(_instance, _args)
          raise "Implement a #rules_passed? method for #{self}"
        end

        def prepare_args(args, object_class)
          preformatted_args = format_args(args, object_class)
          post_format_args(preformatted_args)
        end

        def format_args(args, object_class)
          default_args = fetch_default_args
          args.tap do |arr|
            default_args.each do |key, value|
              arr.insert(0, value) if argument_required?(key, object_class)
            end
          end
        end

        # A hook to implement additional formatting by subclasses
        def post_format_args(_args)
          raise "Implement a #post_format_args method for #{self}"
        end

        def fetch_default_args
          TuneSpec.__send__("#{type}_opts".downcase)
        end

        def argument_required?(arg, klass)
          klass.instance_method(:initialize).parameters.flatten.include?(arg)
        end

        def call_object(file_name)
          ensure_required(file_name)
          const_name = file_name.split('_').each(&:capitalize!).join('')
          const_get(const_name)
        end

        def ensure_required(name)
          path = load_files.detect { |f| f.include?("/#{name}.rb") }
          path ? require("./#{path}") : raise("Unable to find #{name}.rb")
        end

        def load_files
          @files ||= Dir.glob("#{file_directory}/**/*")
        end

        # A hook to implement folder name by subclass
        def file_directory
          raise "Implement a #folder_name method for #{self}"
        end
      end
    end
  end
end
