require 'ffi'
require File.join('FFI', 'utilities')

module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library

      LIBRARY_SUFFIX = FFI::Utilities.library_suffix
      CSOUND_LIBRARY_PATH = File.expand_path(File.join(['..'] * 5, 'ext', 'cs6make', "libcsnd6#{LIBRARY_SUFFIX}"), __FILE__)
      ffi_lib CSOUND_LIBRARY_PATH

    end

  end

end
