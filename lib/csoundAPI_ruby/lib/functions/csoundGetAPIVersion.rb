module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundGetAPIVersion, [], :int

    end

  end

end
