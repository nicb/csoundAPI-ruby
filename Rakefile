require "bundler/gem_tasks"

begin
  require 'byebug'
  require 'rspec/core/rake_task'
  
  RSpec::Core::RakeTask.new(:test => ['FFI:struct:generate', 'fixtures:C:build'])
rescue LoadError
  # no rspec available
end

task :default => :test

#
# load the tasks in lib/tasks
#
Dir.glob(File.expand_path(File.join('..', 'lib', 'tasks', '**', '*.rake'), __FILE__)).each { |f| load f }
