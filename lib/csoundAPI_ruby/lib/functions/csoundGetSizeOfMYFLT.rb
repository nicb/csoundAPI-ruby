module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundGetSizeOfMYFLT, [:pointer], :int

    end

  end

end
