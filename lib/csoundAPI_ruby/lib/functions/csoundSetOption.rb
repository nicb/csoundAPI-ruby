module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundSetOption, [:pointer, :pointer], :int

    end

  end

end
