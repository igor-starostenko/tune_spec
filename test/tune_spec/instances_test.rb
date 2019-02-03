# frozen_string_literal: true

require 'minitest/autorun'
require 'tune_spec'
require_relative '../test_helper'

TuneSpec.configure do |conf|
  conf.directory = DIRECTORY
  conf.steps_page_arg = :page_object
  conf.groups_opts = { env: TEST_ENV, aut: 'WEB' }
  conf.steps_opts = { env: TEST_ENV }
  conf.page_opts = { env: TEST_ENV }
end

include TuneSpec::Instances # rubocop:disable Style/MixinUsage

TestHelper.setup_directory

describe TuneSpec::Instances do
  describe Groups do
    it 'generates an instance' do
      instance = groups(:login, {}, 'Main')
      instance.complete
      instance.class.must_equal LoginGroups
    end
  end

  describe Steps do
    it 'generates an instance' do
      instance = steps(:calculator, page: :demo)
      instance.verify_result
      instance.class.must_equal CalculatorSteps
    end

    it 'has page object' do
      steps(:calculator, page: :demo) do
        page_object.class.must_equal DemoPage
      end
    end
  end

  describe Page do
    it 'generates an instance' do
      instance = pages(:home)
      instance.click_element
      instance.class.must_equal HomePage
    end
  end
end
