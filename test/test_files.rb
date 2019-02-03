# frozen_string_literal: true

require_relative 'test_helper'

TestHelper.create_file(:login, :groups) do
  <<-FILE
    class LoginGroups
      def initialize(test, env:, aut:); end
      def complete; end
    end
  FILE
end

TestHelper.create_file(:calculator, :steps) do
  <<-FILE
    class CalculatorSteps
      attr_reader :page_object
      def initialize(env:, page_object:)
        @env = env
        @page_object = page_object
      end
      def verify_result
        raise unless page_object.title === 'ok'
      end
    end
  FILE
end

TestHelper.create_file(:demo, :page) do
  <<-FILE
    class DemoPage
      def initialize; end
      def title
        'ok'
      end
    end
  FILE
end

TestHelper.create_file(:home, :page) do
  <<-FILE
    class HomePage
      def initialize(env:); end
      def click_element; end
    end
  FILE
end

