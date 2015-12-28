module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundCompileCsd, [:pointer, :pointer], :int

    end

  end

end
