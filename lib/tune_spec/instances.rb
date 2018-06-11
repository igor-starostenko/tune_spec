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
    # @param opts [Hash] additional optional arguments
    # @param block [Block] that yields to self
    # @return [GroupObject]
    # @example
    #   groups(:login).complete
    def groups(name, opts = {}, &block)
      instance_handler(name, Groups, opts, block)
    end

    # Creates an instance of Step or calls an existing
    #
    # @param name [Symbol, String] the prefix of the Step object class
    # @param opts [Hash] additional optional arguments
    # @param block [Block] that yields to self
    # @return [StepObject]
    # @example
    #   steps(:calculator, page: :home).verify_result
    def steps(name, opts = {}, &block)
      instance_handler(name, Steps, opts, block)
    end

    # Creates an instance of Page or calls an existing
    #
    # @param name [Symbol, String] the prefix of the Page object class
    # @param opts [Hash] additional optional arguments
    # @param block [Block] that yields to self
    # @return [PageObject]
    # @example
    #   pages(:home).click_element
    def pages(name, opts = {}, &block)
      instance_handler(name, Page, opts, block)
    end

    private

    # @private
    def instance_handler(name, klass, opts, block)
      method_name = klass.instance_method_name(name)
      instance_klass = klass.call_object(method_name)
      create_instance_method(method_name, klass, instance_klass)
      formatted_opts = klass.format_opts(opts, instance_klass)
      call_instance_method(method_name, formatted_opts, block)
    end

    # @private
    def create_instance_method(method_name, klass, instance_klass)
      return if respond_to?(method_name)
      define_singleton_method(method_name) do |opts = {}|
        instance_var = instance_variable_get("@#{method_name}")
        return instance_var if klass.rules_passed?(instance_var, opts)
        new_instance = create_instance(klass, instance_klass, opts)
        instance_variable_set("@#{method_name}", new_instance)
      end
    end

    # @private
    def create_instance(klass, instance_klass, opts)
      return instance_klass.new(opts) if klass.object_type == :common
      wait_opts = TuneSpec.calabash_wait_opts
      page(instance_klass, opts).await(wait_opts)
    end

    # @private
    def call_instance_method(method_name, opts, block)
      return __send__(method_name, opts) unless block
      __send__(method_name, opts).instance_eval(&block)
    end
  end
end
