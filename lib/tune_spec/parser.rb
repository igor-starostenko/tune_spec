# frozen_string_literal: true

require 'optparse'
require 'fileutils'

module TuneSpec
  # @private
  class Parser
    def self.parse(args)
      new(args).parse
    end

    attr_reader :original_args

    def initialize(args)
      @original_args = args
    end

    def parse
      parser.parse!(original_args)
    end

    # rubocop:disable MethodLength
    def parser
      OptionParser.new do |parser|
        parser.summary_width = 34

        parser.banner = "Usage: tune [options]\n\n"

        parser.on('--init [PATH]',
                  'Create framework folder structure') do |dir|
          base_path = dir || 'lib'
          %w[groups pages steps].each do |folder|
            FileUtils.mkdir_p(base_path)
            path = "#{base_path}/#{folder}"
            exists = directory_exists?(path)
            print_directory(path, exists)
            create_directory(path) unless exists
          end
        end
      end
    end

    private

    def print_directory(dir, exists)
      puts "  #{exists ? :exist : :create}   #{dir}"
    end

    def create_directory(dir)
      Dir.mkdir(dir)
    end

    def directory_exists?(dir)
      Dir.exist?(dir)
    end
  end
end
