module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundPerform, [:pointer], :int

    end

  end

end
