# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'yard-doctest'
require_relative 'test/test_helper'

namespace :test do
  task :setup do
    TestHelper.setup_directory
  end

  task :cleanup do
    TestHelper.remove_directory
  end
end

Rake::TestTask.new do |task|
  task.pattern = 'test/**/*_test.rb'
end

YARD::Doctest::RakeTask.new do |task|
  task.doctest_opts = %w[-v]
  task.pattern = 'lib/**/*.rb'
end
