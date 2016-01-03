module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundGetVersion, [], :int

    end

  end

end
