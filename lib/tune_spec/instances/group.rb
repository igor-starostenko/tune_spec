# frozen_string_literal: true

require_relative 'tuner'

module TuneSpec
  module Instances
    # Defines the group behavior and rules
    class Group < Tuner
      class << self
        private

        # Group specific rules
        def rules_passed?(instance, _args)
          instance
        end
      end
    end
  end
end
