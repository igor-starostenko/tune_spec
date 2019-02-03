# frozen_string_literal: true

require 'fileutils'

TEST_ENV = 'STG'
DIRECTORY = 'test_tmp'

# Dynamically generates test files
module TestHelper
  def self.create_file(name, type, &block)
    folder_name = type == :page ? 'pages' : type.to_s
    file_name = "#{DIRECTORY}/#{folder_name}/#{name}_#{type}.rb"
    FileUtils.mkdir_p("#{DIRECTORY}/#{folder_name}")
    File.open(file_name, 'w+') { |f| f << block.call }
  end

  def self.remove_test_directory
    FileUtils.rm_rf(DIRECTORY)
  end
end

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
      def initialize(env:, page_object:)
        @env = env
        @page_object = page_object
      end
      def verify_result
        raise unless @page_object.title === 'ok'
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
