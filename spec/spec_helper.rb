if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
else
	require 'simplecov'
  SimpleCov.start
end
$LOAD_PATH.unshift File.expand_path(File.join(['..'] * 2, 'lib'), __FILE__)
require 'csoundAPI_ruby'
require 'byebug'
