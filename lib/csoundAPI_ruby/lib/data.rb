module CsoundAPIRuby
  module Lib
    module Data
      PATH = File.expand_path(File.join('..', 'data'), __FILE__)
    end
  end
end

begin
  %w(
    header
    myflt
    csound_params
  ).each { |f| require File.join(CsoundAPIRuby::Lib::Data::PATH, f) }
rescue LoadError => msg
  STDERR.puts("Have you run the rake csound:struct:generate task? (error: #{msg})")
end
