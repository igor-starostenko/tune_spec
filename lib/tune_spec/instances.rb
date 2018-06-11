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
    # @param opts [Hash] optional arguments
    # @param args [Any] extra arguments
    # @param block [Block] that yields to self
    # @return [GroupObject]
    # @example
    #   groups(:login, {}, 'Main').complete
    def groups(name, opts = {}, *args, &block)
      instance_handler(name, Groups, opts, *args, block)
    end

    # Creates an instance of Step or calls an existing
    #
    # @param name [Symbol, String] the prefix of the Step object class
    # @param opts [Hash] optional arguments
    # @param args [Any] extra arguments
    # @param block [Block] that yields to self
    # @return [StepObject]
    # @example
    #   steps(:calculator, page: :home).verify_result
    def steps(name, opts = {}, *args, &block)
      instance_handler(name, Steps, opts, *args, block)
    end

    # Creates an instance of Page or calls an existing
    #
    # @param name [Symbol, String] the prefix of the Page object class
    # @param opts [Hash] optional arguments
    # @param args [Any] extra arguments
    # @param block [Block] that yields to self
    # @return [PageObject]
    # @example
    #   pages(:home).click_element
    def pages(name, opts = {}, *args, &block)
      instance_handler(name, Page, opts, *args, block)
    end

    private

    # @private
    def instance_handler(name, klass, opts, *args, block)
      method_name = klass.instance_method_name(name)
      instance_klass = klass.call_object(method_name)
      create_instance_method(method_name, klass, instance_klass)
      args << klass.format_opts(opts, instance_klass)
      call_instance_method(method_name, *args, block)
    end

    # @private
    def create_instance_method(method_name, klass, instance_klass)
      return if respond_to?(method_name)
      define_singleton_method(method_name) do |*args|
        instance_var = instance_variable_get("@#{method_name}")
        return instance_var if klass.rules_passed?(instance_var, args.first)
        new_instance = create_instance(klass, instance_klass, *args)
        instance_variable_set("@#{method_name}", new_instance)
      end
    end

    # @private
    def create_instance(klass, instance_klass, *args)
      return instance_klass.new(*args) if klass.object_type == :common
      wait_opts = TuneSpec.calabash_wait_opts
      page(instance_klass, *args).await(wait_opts)
    end

    # @private
    def call_instance_method(method_name, *args, block)
      return __send__(method_name, *args) unless block
      __send__(method_name, *args).instance_eval(&block)
    end
  end
end
