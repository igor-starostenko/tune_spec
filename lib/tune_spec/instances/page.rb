# frozen_string_literal: true

require_relative 'tuner'

module TuneSpec
  module Instances
    # Defines pages behavior and rules
    class Page < Tuner
      class << self
        # Page specific rules
        def rules_passed?(instance, _args)
          instance
        end

        private

        def file_directory
          "#{TuneSpec.directory}/#{type}s"
        end
      end
    end
  end
end
