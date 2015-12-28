module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundGetNchnls, [:pointer], :uint32

    end

  end

end
