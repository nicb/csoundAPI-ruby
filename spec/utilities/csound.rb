module Spec
  module Utilities

    def csound_init()
      cs = CsoundAPIRuby::Lib::Functions::csoundCreate(nil)
  
      res = yield(cs)
  
      res
    ensure
      CsoundAPIRuby::Lib::Functions::csoundCleanup(cs)
      CsoundAPIRuby::Lib::Functions::csoundDestroy(cs)
    end

    def csound_perform()
      res = nil
      csound_init do
        |cs|
        res = CsoundAPIRuby::Lib::Functions::csoundCompile(cs, @args.size, FFI::Utilities.set_argv(@args))
        raise StandardError, "CsoundAPIRuby::Lib::Functions::csoundCompile returned #{res}" unless res == 0
  
        yield(cs)
      end
      res
    end

  end
end
