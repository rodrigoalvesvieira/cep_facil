# coding: utf-8

require 'rubygems'
require 'rake'

task :test => :spec

task :default => :spec

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--backtrace --color'
end
