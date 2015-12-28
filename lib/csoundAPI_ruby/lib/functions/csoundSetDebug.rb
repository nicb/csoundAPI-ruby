module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundSetDebug, [:pointer, :int], :void

    end

  end

end
