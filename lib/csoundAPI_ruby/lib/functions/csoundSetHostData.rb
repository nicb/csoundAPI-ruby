module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundSetHostData, [:pointer, :pointer], :void

    end

  end

end
