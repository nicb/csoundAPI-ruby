module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundPerformKsmps, [:pointer], :int

    end

  end

end
