# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'yard-doctest'

task default: %w[yard:doctest]

YARD::Doctest::RakeTask.new do |task|
  task.doctest_opts = %w[-v]
  task.pattern = 'lib/**/*.rb'
end
