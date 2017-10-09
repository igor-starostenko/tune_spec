# frozen_string_literal: true

require 'tune_spec'
require 'fileutils'

include TuneSpec::Instances
TuneSpec.directory = 'test'

def create_file(name, type)
  FileUtils.mkdir_p("test/#{type}")
  File.open("test/#{type}/#{name}_#{type}.rb", 'w+') do |file|
    file << file_content(name, type)
  end
end

def file_content(name, type)
  <<~EOF
    class_name = "#{name.capitalize}#{type.capitalize}"
    klass = Object.const_set(class_name, Class.new)

    klass.class_eval do
      define_method('complete') do
        puts "#{type} method called"
      end
    end
  EOF
end

YARD::Doctest.configure do |doctest|
  doctest.before('TuneSpec::Instances') do
    create_file(:login, :groups)
  end

  doctest.after('TuneSpec::Instances') do
    FileUtils.rm_rf('test')
  end
end
