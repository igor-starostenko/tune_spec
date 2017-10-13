# frozen_string_literal: true

require_relative 'tuner'

module TuneSpec
  module Instances
    # Defines pages behavior and rules
    class Page < Tuner
      class << self
        private

        # Page specific rules
        def rules_passed?(instance, _args)
          instance
        end

        # Additional formatting of args
        def post_format_args(args)
          args
        end

        def folder_name
          "#{TuneSpec.directory}/#{type}s"
        end
      end
    end
  end
end
