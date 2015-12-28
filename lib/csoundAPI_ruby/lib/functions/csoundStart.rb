module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundStart, [:pointer], :int

    end

  end

end
