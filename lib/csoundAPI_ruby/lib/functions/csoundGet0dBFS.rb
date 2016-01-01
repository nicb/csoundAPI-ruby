module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundGet0dBFS, [:pointer], :MYFLT

    end

  end

end
