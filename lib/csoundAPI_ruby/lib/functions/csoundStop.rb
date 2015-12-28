module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundStop, [:pointer], :void

    end

  end

end
