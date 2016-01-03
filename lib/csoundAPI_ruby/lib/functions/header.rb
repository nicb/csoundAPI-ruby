require 'ffi'
require File.join('FFI', 'utilities')

module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library

      CSOUND_LIBRARY_PATH = File.expand_path(File.join(['..'] * 5, 'ext', 'cs6make'), __FILE__)
      CSOUND_LIBRARY_FILE = File.join(CSOUND_LIBRARY_PATH, FFI.map_library_name('csnd6'))
      ffi_lib CSOUND_LIBRARY_FILE

    end

  end

end
