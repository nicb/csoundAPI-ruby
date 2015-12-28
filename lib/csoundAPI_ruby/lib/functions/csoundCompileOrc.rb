module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundCompileOrc, [:pointer, :pointer], :int

    end

  end

end
