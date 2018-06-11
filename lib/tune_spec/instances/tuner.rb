# frozen_string_literal: true

module TuneSpec
  module Instances
    # Abstract class for Group, Step and Page
    class Tuner
      class << self
        def instance_method_name(name)
          "#{name}_#{type}".downcase
        end

        # A hook to define rules by subclasses
        def rules_passed?(_instance, _args)
          raise "Implement a #rules_passed? method for #{self}"
        end

        def format_args(args, object_klass)
          default_args = fetch_default_args
          args.tap do |arr|
            default_args.each do |key, value|
              arr.insert(0, value) if argument_required?(key, object_klass)
            end
          end
        end

        def call_object(file_name)
          ensure_required(file_name)
          const_name = file_name.split('_').each(&:capitalize!).join('')
          const_get(const_name)
        end

        def object_type
          :common
        end

        private

        def type
          @type ||= itself.to_s.split('::').last.downcase
        end

        def fetch_default_args
          TuneSpec.__send__("#{type}_opts".downcase)
        end

        def argument_required?(arg, klass)
          klass.instance_method(:initialize).parameters.flatten.include?(arg)
        end

        def ensure_required(name)
          path = project_files.detect { |f| f.include?("/#{name}.rb") }
          path ? require("./#{path}") : raise("Unable to find #{name}.rb")
        end

        def project_files
          @project_files ||= Dir.glob("#{file_directory}/**/*")
        end

        # A hook to implement folder name by subclass
        def file_directory
          raise "Implement a #folder_name method for #{self}"
        end
      end
    end
  end
end
