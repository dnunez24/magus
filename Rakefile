require "bundler/gem_tasks"
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'magus/version'

Cucumber::Rake::Task.new(:features)
RSpec::Core::RakeTask.new(:spec)

task :test => [:features, :spec]
task :default => :test

desc "Display current gem version"
task :version do
  puts "Current Version: #{Magento::VERSION}"
end

namespace :version do
  desc "Bump version (defaults to patch)"
  task :bump => "bump:patch"

  namespace :bump do
    desc "Bump major version"
    task :major => :version do |t|
      bump_version(task_tail(t))
    end

    desc "Bump minor version"
    task :minor => :version do |t|
      bump_version(task_tail(t))
    end

    desc "Bump patch version"
    task :patch => :version do |t|
      bump_version(task_tail(t))
    end
  end
end

def split_task_name(task)
  task.name.split(":")
end

def task_tail(task)
  split_task_name(task).last
end

def bump_version(segment)
  segments = Magento::VERSION.split(".").map(&:to_i)

  case segment
  when "major"
    segments[0] += 1
    segments[1] = 0
    segments[2] = 0
  when "minor"
    segments[1] += 1
    segments[2] = 0
  when "patch"
    segments[2] += 1
  end

  new_version = segments.join(".")

  file = File.expand_path("../lib/magus/version.rb", __FILE__)
  new_text = File.read(file).gsub(Magento::VERSION, new_version)
  File.open(file, 'w') {|f| f.puts new_text}

  puts "New version: #{new_version}"
end