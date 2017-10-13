# frozen_string_literal: true

require_relative 'tuner'

module TuneSpec
  module Instances
    # Defines the group behavior and rules
    class Groups < Tuner
      class << self
        private

        # Group specific rules
        def rules_passed?(instance, _args)
          instance
        end

        # Additional formatting of args
        def post_format_args(args)
          args
        end

        def file_directory
          "#{TuneSpec.directory}/#{type}"
        end
      end
    end
  end
end
