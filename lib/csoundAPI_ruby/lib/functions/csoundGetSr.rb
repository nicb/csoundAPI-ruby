module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundGetSr, [:pointer], :MYFLT

    end

  end

end
