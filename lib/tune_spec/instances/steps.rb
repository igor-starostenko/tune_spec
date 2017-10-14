# frozen_string_literal: true

require_relative 'tuner'

module TuneSpec
  module Instances
    # Defines the steps behavior and rules
    class Steps < Tuner
      class << self
        # Steps specific rules
        def rules_passed?(instance, args)
          same_page?(instance, args[1]) if args
        end

        private

        # Verifies if the step requires a page_object
        def same_page?(instance, page)
          return false unless instance
          return true unless instance.respond_to?(:page_object)
          return true unless general_steps?(instance)
          page.instance_of?(instance.page_object.class)
        end

        def general_steps?(instance)
          argument_required?(:page_object, instance.class)
        end

        def file_directory
          "#{TuneSpec.directory}/#{type}"
        end
      end
    end
  end
end
