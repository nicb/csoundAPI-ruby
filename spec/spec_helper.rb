require 'codeclimate-test-reporter'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/lib/csoundAPI_ruby/lib/data/myflt.rb'
  add_filter '/lib/tasks/'
  formatter SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
  ])
end
$LOAD_PATH.unshift File.expand_path(File.join(['..'] * 2, 'lib'), __FILE__)
require File.join('bundler', 'setup')
require 'byebug'
require 'csoundAPI_ruby'
require File.join('FFI', 'utilities')

SPEC_FIXTURE_PATH = File.expand_path(File.join('..', 'fixtures'), __FILE__)
SPEC_CSOUND_FIXTURE_PATH = File.join(SPEC_FIXTURE_PATH, 'csound')
SPEC_C_FIXTURE_PATH = File.join(SPEC_FIXTURE_PATH, 'C')

#
# Some tests are brittle and they break in some way or another, so
# won't run them here too (unless we get them to work of course)
#
RSpec.configure do |c|
  conf_specs = { :broken => true, :obsolete => true }
# conf_specs.update(:broken_on_travis => true) if ENV['TRAVIS']
  c.filter_run_excluding conf_specs
end
