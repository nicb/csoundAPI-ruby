require 'ffi'

module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundGetKsmps, [:pointer], :uint32

    end

  end

end
