#!/usr/bin/env rake
require 'rake'
require 'rake/testtask'
require "bundler/gem_tasks"

desc 'Run tests'
Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/*_test.rb'
  t.verbose = true
  t.warning = true
end
