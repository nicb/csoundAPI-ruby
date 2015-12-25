require_relative '../spec_helper'
require_relative '../utilities/quiet_stderr'

describe CsoundAPIRuby::CsoundLib do

  context 'basic functions' do

    before :example do
      @args = [ '--messagelevel=0', '--nosound', '--nodisplays', File.join(SPEC_CSOUND_FIXTURE_PATH, 'simple.csd') ]
    end

    it 'can create a csound variable' do
      quiet_stderr do
        expect((cs = CsoundAPIRuby::CsoundLib::csoundCreate(nil)).class).to be(FFI::Pointer)
        expect(CsoundAPIRuby::CsoundLib::csoundDestroy(cs)).to be(nil)
      end
    end

    it 'can do a compile cycle' do
      quiet_stderr do
        expect((cs = CsoundAPIRuby::CsoundLib::csoundCreate(nil)).class).to be(FFI::Pointer)
        expect((argv = FFI::Utilities.set_argv(@args)).class).to be(FFI::MemoryPointer)
        expect(res = CsoundAPIRuby::CsoundLib::csoundCompile(cs, @args.size, argv)).to eq(0)
        expect(CsoundAPIRuby::CsoundLib::csoundDestroy(cs)).to be(nil)
      end
    end

    it 'can run the full cycle' do
      quiet_stderr do
        expect((cs = CsoundAPIRuby::CsoundLib::csoundCreate(nil)).class).to be(FFI::Pointer)
        expect((argv = FFI::Utilities.set_argv(@args)).class).to be(FFI::MemoryPointer)
        expect(res = CsoundAPIRuby::CsoundLib::csoundCompile(cs, @args.size, argv)).to eq(0)
        while(res == 0)
          expect(res = CsoundAPIRuby::CsoundLib::csoundPerformKsmps(cs)).to be >= 0
        end
        expect(CsoundAPIRuby::CsoundLib::csoundCleanup(cs)).to be(nil)
        expect(CsoundAPIRuby::CsoundLib::csoundDestroy(cs)).to be(nil)
      end
    end

  end

end
