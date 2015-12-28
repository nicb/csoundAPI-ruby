module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundCompile, [:pointer, :int, :pointer], :int

    end

  end

end
