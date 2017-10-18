# frozen_string_literal: true

module TuneSpec
  # Defines all configurable attributes of TuneSpec
  module Configuration
    VALID_CONFIG_KEYS = %i[directory steps_page_arg
                           page_opts steps_opts groups_opts].freeze

    DEFAULT_DIRECTORY = 'lib'

    DEFAULT_STEPS_PAGE_ARG = :page

    DEFAULT_PAGE_OPTS = {}.freeze

    DEFAULT_STEPS_OPTS = {}.freeze

    DEFAULT_GROUPS_OPTS = {}.freeze

    VALID_CONFIG_KEYS.each { |key| attr_accessor key }

    # Make sure the default values are set when the module is 'extended'
    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def reset
      VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", self::Configuration.const_get("DEFAULT_#{key}".upcase))
      end
    end
  end
end
