require 'optparse'

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

		def parser
      OptionParser.new do |parser|
        parser.summary_width = 34

        parser.banner = "Usage: tune [options]\n\n"

        parser.on('spec --init PATH',
                  'Create framework folder structure') do |dir|
          base_path = dir || 'lib'
          Dir.mkdir(base_path)
          %w[groups pages steps].each { |dir| Dir.mkdir("#{base_path}/#{dir} }
        end
      end
    end
  end
end
