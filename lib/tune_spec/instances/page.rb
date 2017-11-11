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

        def create_instance(file_name, *args)
          return super unless TuneSpec.calabash_enabled
          create_calabash_instance(file_name, *args)
        end

        private

        def create_calabash_instance(file_name, *args)
          wait_opts = TuneSpec.calabash_wait_opts
          puts wait_opts
          page(call_object(file_name), *args).await(wait_opts)
        end

        def file_directory
          "#{TuneSpec.directory}/#{type}s"
        end
      end
    end
  end
end
