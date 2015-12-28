module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundGetCurrentTimeSamples, [:pointer], :int64

    end

  end

end
