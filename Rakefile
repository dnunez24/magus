require "bundler/gem_tasks"
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

Cucumber::Rake::Task.new(:features)
RSpec::Core::RakeTask.new(:spec)

task :test => [:features, :spec]
task :default => :test
