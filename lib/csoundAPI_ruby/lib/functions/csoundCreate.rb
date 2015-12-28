module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundCreate, [:pointer], :pointer

    end

  end

end
