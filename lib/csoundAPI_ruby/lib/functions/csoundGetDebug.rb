module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundGetDebug, [:pointer], :int

    end

  end

end
