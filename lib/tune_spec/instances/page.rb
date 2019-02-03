# frozen_string_literal: true

require_relative 'tuner'

module TuneSpec
  module Instances
    # Defines pages behavior and rules
    class Page < Tuner
      class << self
        # Page specific rules
        def rules_passed?(instance, _opts)
          instance
        end

        def object_type
          return super unless TuneSpec.calabash_enabled

          :calabash_page
        end

        private

        def file_directory
          "#{TuneSpec.directory}/#{type}s"
        end
      end
    end
  end
end
