module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundGetHostData, [:pointer], :pointer

    end

  end

end
