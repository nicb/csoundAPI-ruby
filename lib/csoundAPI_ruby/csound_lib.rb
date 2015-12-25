require 'ffi'

module CsoundAPIRuby

  module CsoundLib

    extend FFI::Library

    CSOUND_LIBRARY_PATH = File.expand_path(File.join(['..'] * 3, 'ext', 'cs6make', 'libcsnd6.so'), __FILE__)
    ffi_lib CSOUND_LIBRARY_PATH

    #
    # basic function handlers
    #
    attach_function :csoundCreate, [:pointer], :pointer
    attach_function :csoundCompile, [:pointer, :int, :pointer], :int
    attach_function :csoundPerformKsmps, [:pointer], :int
    attach_function :csoundCleanup, [:pointer], :void
    attach_function :csoundDestroy, [:pointer], :void


  end

end
