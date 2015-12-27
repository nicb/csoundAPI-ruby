require 'ffi'

module CsoundAPIRuby

  module CsoundLib

    extend FFI::Library

    CSOUND_LIBRARY_PATH = File.expand_path(File.join(['..'] * 3, 'ext', 'cs6make', 'libcsnd6.so'), __FILE__)
    ffi_lib CSOUND_LIBRARY_PATH

    #
    # basic function handlers
    #
    # instantiation functions
    #
    attach_function :csoundCreate, [:pointer], :pointer
    attach_function :csoundCompile, [:pointer, :int, :pointer], :int
    attach_function :csoundCompileArgs, [:pointer, :int, :pointer], :int
    attach_function :csoundCompileCsd, [:pointer, :pointer], :int
    attach_function :csoundCompileOrc, [:pointer, :pointer], :int
    #
    # perform functions
    #
    attach_function :csoundPerformKsmps, [:pointer], :int
    attach_function :csoundPerform, [:pointer], :int
    attach_function :csoundPerformBuffer, [:pointer], :int
    attach_function :csoundStart, [:pointer], :int
    attach_function :csoundStop, [:pointer], :void
    #
    # cleanup functions
    #
    attach_function :csoundCleanup, [:pointer], :void
    attach_function :csoundDestroy, [:pointer], :void
    attach_function :csoundReset, [:pointer], :void


  end

end
