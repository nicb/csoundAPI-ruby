module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundPerformBuffer, [:pointer], :int

    end

  end

end
