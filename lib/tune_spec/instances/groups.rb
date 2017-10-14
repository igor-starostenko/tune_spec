# frozen_string_literal: true

require_relative 'tuner'

module TuneSpec
  module Instances
    # Defines the group behavior and rules
    class Groups < Tuner
      class << self
        # Groups specific rules
        def rules_passed?(instance, _args)
          instance
        end

        private

        def file_directory
          "#{TuneSpec.directory}/#{type}"
        end
      end
    end
  end
end
