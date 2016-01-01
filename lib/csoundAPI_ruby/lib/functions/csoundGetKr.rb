module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundGetKr, [:pointer], :MYFLT

    end

  end

end
