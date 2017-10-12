# frozen_string_literal: true

require 'tune_spec'
require 'fileutils'

include TuneSpec::Instances
TEST_ENV = 'STG'

TuneSpec.configure do |conf|
  conf.directory = 'test'
  conf.group_opts = { env: TEST_ENV }
  conf.steps_opts = { env: TEST_ENV }
  conf.page_opts = { env: TEST_ENV }
end

def create_file(name, type)
  FileUtils.mkdir_p("test/#{type}s")
  File.open("test/#{type}s/#{name}_#{type}.rb", 'w+') do |file|
    file << file_content(name, type)
  end
end

def file_content(name, type)
  <<~FILE
    class_name = "#{name.capitalize}#{type.capitalize}"
    klass = Object.const_set(class_name, Class.new)

    klass.class_eval do
      case "#{type}"
      when 'group'
        define_method('initialize') do |env|; end
        define_method('complete') do; end
      when 'steps'
        define_method('initialize') do |env, page_object|; end
        define_method('verify_result') do; end
      when 'page'
        define_method('initialize') do |env|; end
        define_method('click_element') do; end
      end
    end
  FILE
end

YARD::Doctest.configure do |doctest|
  doctest.before('TuneSpec::Instances') do
    create_file(:login, :group)
    create_file(:calculator, :steps)
    create_file(:home, :page)
  end

  doctest.after('TuneSpec::Instances') do
    FileUtils.rm_rf('test')
  end
end
