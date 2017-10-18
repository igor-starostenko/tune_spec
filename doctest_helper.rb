# frozen_string_literal: true

require 'tune_spec'
require 'fileutils'

include TuneSpec::Instances
TEST_ENV = 'STG'

TuneSpec.configure do |conf|
  conf.directory = 'test'
  conf.steps_page_arg = :page_object
  conf.groups_opts = { env: TEST_ENV }
  conf.steps_opts = { env: TEST_ENV }
  conf.page_opts = { env: TEST_ENV }
end

def create_file(name, type)
  folder_name = type == :page ? 'pages' : type.to_s
  file_name = "test/#{folder_name}/#{name}_#{type}.rb"
  FileUtils.mkdir_p("test/#{folder_name}")
  File.open(file_name, 'w+') { |f| f << file_content(name, type) }
end

def file_content(name, type)
  <<~FILE
    class_name = "#{name.capitalize}#{type.capitalize}"
    klass = Object.const_set(class_name, Class.new)

    klass.class_eval do
      case "#{type}"
      when 'groups'
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

create_file(:login, :groups)
create_file(:calculator, :steps)
create_file(:home, :page)

YARD::Doctest.configure do |doctest|
  doctest.after_run do
    FileUtils.rm_rf('test')
  end
end
