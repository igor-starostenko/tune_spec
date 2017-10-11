# frozen_string_literal: true

require 'tune_spec'
require 'fileutils'

include TuneSpec::Instances
TEST_ENV = 'STG'

TuneSpec.configure do |conf|
  conf.directory = 'test'
  conf.group_opts = { env: TEST_ENV }
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
      define_method('complete') do
        puts "#{type} method called"
      end
    end
  FILE
end

YARD::Doctest.configure do |doctest|
  doctest.before('TuneSpec::Instances') do
    create_file(:login, :group)
  end

  doctest.after('TuneSpec::Instances') do
    FileUtils.rm_rf('test')
  end
end
