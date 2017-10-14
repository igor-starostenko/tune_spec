# frozen_string_literal: true

require_relative 'instances/groups'
require_relative 'instances/steps'
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
    #   groups(:login).complete
    def groups(name, *args, &block)
      instance_handler(name, Groups, *args, block)
    end

    # Creates an instance of Step or calls an existing
    #
    # @param name [Symbol, String] the prefix of the Step object class
    # @param args [Any] additional optional arguments
    # @param block [Block] that yields to self
    # @return [StepObject]
    # @example
    #   steps(:calculator, page: :home).verify_result
    def steps(name, *args, page: nil, &block)
      args.insert(0, pages(page)) if page
      instance_handler(name, Steps, *args, block)
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
      instance_handler(name, Page, *args, block)
    end

    private

    # @private
    def instance_handler(name, klass, *args, block)
      klass.create_instance_method(name)
      klass.call_instance_method(name, *args, block)
    end
  end
end
