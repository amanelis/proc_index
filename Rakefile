# encoding: utf-8

require 'rubygems'

begin
  require 'bundler/setup'
rescue LoadError => e
  abort e.message
end

require 'rake'

require 'awesome_print'
AwesomePrint.irb!

require 'rubygems/tasks'
Gem::Tasks.new

require 'rdoc/task'
RDoc::Task.new
task doc: :rdoc

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task test:    :spec
task default: :spec

directory '.'
task :dgem do
  system 'rm *.gem'
end

task :bgem do
  system 'gem build *.gemspec'
end
