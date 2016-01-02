require 'byebug'

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
  ).each do |f| byebug if f == 'csound_params'; require File.join(CsoundAPIRuby::Lib::Data::PATH, f); end
rescue LoadError => msg
  STDERR.puts("Have you run the rake FFI:struct:generate task?\n\t(error: #{msg})")
  raise LoadError
end
