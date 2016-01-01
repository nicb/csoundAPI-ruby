require 'ffi'
require File.join('FFI', 'utilities')

module CsoundAPIRuby

  module Lib

    module Data

      extend FFI::Library

      CSOUND_INCLUDE_PATH = File.expand_path(File.join(['..'] * 5, 'ext', 'csound', 'include'), __FILE__)

    end

  end

end
