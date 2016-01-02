if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start do
    add_filter '/spec/'
    add_filter '/lib/csoundAPI_ruby/lib/data/myflt.rb'
    add_filter '/lib/tasks/'
  end
else
	require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
    add_filter '/lib/csoundAPI_ruby/lib/data/myflt.rb'
    add_filter '/lib/tasks/'
  end
end
$LOAD_PATH.unshift File.expand_path(File.join(['..'] * 2, 'lib'), __FILE__)
require File.join('bundler', 'setup')
require 'byebug'
require 'csoundAPI_ruby'
require File.join('FFI', 'utilities')

SPEC_FIXTURE_PATH = File.expand_path(File.join('..', 'fixtures'), __FILE__)
SPEC_CSOUND_FIXTURE_PATH = File.join(SPEC_FIXTURE_PATH, 'csound')
SPEC_C_FIXTURE_PATH = File.join(SPEC_FIXTURE_PATH, 'C')
