# frozen_string_literal: true

require_relative 'instances/group'

module TuneSpec
  # Maps instance variables of pages, steps and groups
  # to corresponding objects under framework directory
  module Instances
    attr_reader :files

    # Creates or calls an existing instance of Groups
    #
    # @param name [Symbol, String] the prefix of the Groups class
    # @param args [Any] additional optional arguments
    # @param block
    # @example
    #   group(:login).complete
    def group(name, *args, &block)
      instance_handler(name, :group, *args, block)
    end

    def step(name, *args, &block)
      instance_handler(name, :step, *args, block)
    end

    def page(name, *args, &block)
      instance_handler(name, :page, *args, block)
    end

    private

    def instance_handler(name, type, *args, block)
      type_helper = const_get(type.capitalize)
      type_helper.create_instance_method(name)
      type_helper.call_instance_method(name, *args, block)
    end
  end
end
