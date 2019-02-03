# frozen_string_literal: true

require 'tune_spec'
require_relative 'test/test_helper'

include TuneSpec # rubocop:disable Style/MixinUsage

TuneSpec.configure do |conf|
  conf.directory = DIRECTORY
  conf.steps_page_arg = :page_object
  conf.groups_opts = { env: TEST_ENV, aut: 'WEB' }
  conf.steps_opts = { env: TEST_ENV }
  conf.page_opts = { env: TEST_ENV }
end

TestHelper.setup_directory

YARD::Doctest.configure do |doctest|
  doctest.after_run do
    TestHelper.remove_directory
  end
end
