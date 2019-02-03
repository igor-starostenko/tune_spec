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

  def self.setup_directory
    require_relative 'test_files'
  end

  def self.remove_directory
    FileUtils.rm_rf(DIRECTORY)
  end
end
