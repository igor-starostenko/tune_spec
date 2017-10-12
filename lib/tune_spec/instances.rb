# frozen_string_literal: true

require_relative 'instances/group'
require_relative 'instances/step'
require_relative 'instances/page'

module TuneSpec
  # Maps instance variables of pages, steps and groups
  # to corresponding objects under framework directory
  module Instances
    # Creates an instance of Group or calls an existing
    #
    # @param name [Symbol, String] the prefix of the Groups object class
    # @param args [Any] additional optional arguments
    # @param block [Block] that yields to self
    # @return [GroupObject]
    # @example
    #   group(:login).complete
    def group(name, *args, &block)
      instance_handler(name, :group, *args, block)
    end

    # Creates an instance of Step or calls an existing
    #
    # @param name [Symbol, String] the prefix of the Step object class
    # @param args [Any] additional optional arguments
    # @param block [Block] that yields to self
    # @return [StepObject]
    # @example
    #   steps(:calculator, page: :home).verify_result
    def steps(name, *args, &block)
      instance_handler(name, :steps, *args, block)
    end

    # Creates an instance of Page or calls an existing
    #
    # @param name [Symbol, String] the prefix of the Page object class
    # @param args [Any] additional optional arguments
    # @param block [Block] that yields to self
    # @return [PageObject]
    # @example
    #   pages(:home).click_element
    def pages(name, *args, &block)
      instance_handler(name, :page, *args, block)
    end

    private

    # @private
    def instance_handler(name, type, *args, block)
      type_helper = const_get(type.capitalize)
      type_helper.create_instance_method(name)
      type_helper.call_instance_method(name, *args, block)
    end
  end
end
