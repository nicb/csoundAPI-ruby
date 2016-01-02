require 'ffi'
require File.join('FFI', 'utilities')

module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library

      CSOUND_LIBRARY_PATH = File.expand_path(File.join(['..'] * 5, 'ext', 'cs6make', FFI.map_library_name('csnd6')), __FILE__)
      ffi_lib CSOUND_LIBRARY_PATH

    end

  end

end
