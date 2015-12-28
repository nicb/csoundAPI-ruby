require 'ffi'

module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library

      CSOUND_LIBRARY_PATH = File.expand_path(File.join(['..'] * 5, 'ext', 'cs6make', 'libcsnd6.so'), __FILE__)
      ffi_lib CSOUND_LIBRARY_PATH

    end

  end

end
