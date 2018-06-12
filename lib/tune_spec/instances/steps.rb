# frozen_string_literal: true

require_relative 'tuner'

module TuneSpec
  module Instances
    # Defines the steps behavior and rules
    class Steps < Tuner
      class << self
        # Steps specific rules
        def rules_passed?(instance, opts = {})
          return nil if opts.nil?
          same_page?(instance, opts[:page]) unless opts.empty?
        end

        private

        # Verifies if the step requires a page_object
        def same_page?(instance, page)
          return false unless instance
          return true unless instance.respond_to?(page_arg)
          return true unless general_steps?(instance)
          page.instance_of?(instance.page_object.class)
        end

        def general_steps?(instance)
          argument_required?(page_arg, instance.class)
        end

        def file_directory
          "#{TuneSpec.directory}/#{type}"
        end

        def page_arg
          TuneSpec.steps_page_arg
        end

        def pre_format_opts(opts)
          return opts unless opts.key?(:page)
          opts.tap { |hash| hash[page_arg] = hash.delete(:page) }
        end
      end
    end
  end
end
