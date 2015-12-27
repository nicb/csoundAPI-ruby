require_relative '../spec_helper'
require_relative '../utilities/quiet_stderr'

describe CsoundAPIRuby::CsoundLib do

  context 'basic functions' do

    before :example do
      @csd_filename = File.join(SPEC_CSOUND_FIXTURE_PATH, 'simple.csd')
      @dur = 9.4
      @sr = 44100.0
      @kr = 441.0
      @ksmps = (@sr / @kr).ceil
      @nsamples = (@sr * @dur).ceil
      @ksmps_cycles = (@nsamples / @ksmps.to_f).ceil
      @frame_size = 1024 # size of a frame
      @n_frames = (@nsamples / @frame_size.to_f).ceil  # frames produced by the above file (9.4 secs @ 44100 = 1620 @frame_size-sample frames)
      @args = [ 'fake_csound', "-b #{@frame_size}", '--messagelevel=0', '--nosound', '--nodisplays', @csd_filename ]
    end

    context 'creation/destruction functions' do

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
  
      it 'can compile args' do
        quiet_stderr do
          expect((cs = CsoundAPIRuby::CsoundLib::csoundCreate(nil)).class).to be(FFI::Pointer)
          expect((argv = FFI::Utilities.set_argv(@args)).class).to be(FFI::MemoryPointer)
          expect(res = CsoundAPIRuby::CsoundLib::csoundCompileArgs(cs, @args.size, argv)).to eq(0)
          expect(CsoundAPIRuby::CsoundLib::csoundCleanup(cs)).to be(nil)
          expect(CsoundAPIRuby::CsoundLib::csoundDestroy(cs)).to be(nil)
        end
      end
  
      it 'can compile csds' do
        quiet_stderr do
          expect((cs = CsoundAPIRuby::CsoundLib::csoundCreate(nil)).class).to be(FFI::Pointer)
          expect(res = CsoundAPIRuby::CsoundLib::csoundCompileCsd(cs, FFI::Utilities.set_string(@csd_filename))).to eq(0)
          expect(CsoundAPIRuby::CsoundLib::csoundCleanup(cs)).to be(nil)
          expect(CsoundAPIRuby::CsoundLib::csoundDestroy(cs)).to be(nil)
        end
      end

    end

    context 'performance functions' do

      it 'can run the full cycle with csoundPerformKsmps' do
        quiet_stderr do
          expect((cs = CsoundAPIRuby::CsoundLib::csoundCreate(nil)).class).to be(FFI::Pointer)
          expect((argv = FFI::Utilities.set_argv(@args)).class).to be(FFI::MemoryPointer)
          expect(res = CsoundAPIRuby::CsoundLib::csoundCompile(cs, @args.size, argv)).to eq(0)
          cnt = res = 0
          while(res == 0)
            expect(res = CsoundAPIRuby::CsoundLib::csoundPerformKsmps(cs)).to be >= 0
            cnt += 1
          end
          expect(cnt).to eq(@ksmps_cycles)
          expect(CsoundAPIRuby::CsoundLib::csoundCleanup(cs)).to be(nil)
          expect(CsoundAPIRuby::CsoundLib::csoundDestroy(cs)).to be(nil)
        end
      end
  
      it 'can run the full cycle with csoundPerform' do
        quiet_stderr do
          expect((cs = CsoundAPIRuby::CsoundLib::csoundCreate(nil)).class).to be(FFI::Pointer)
          expect((argv = FFI::Utilities.set_argv(@args)).class).to be(FFI::MemoryPointer)
          expect(res = CsoundAPIRuby::CsoundLib::csoundCompile(cs, @args.size, argv)).to eq(0)
          expect(res = CsoundAPIRuby::CsoundLib::csoundPerform(cs)).to eq(2)
          expect(CsoundAPIRuby::CsoundLib::csoundCleanup(cs)).to be(nil)
          expect(CsoundAPIRuby::CsoundLib::csoundDestroy(cs)).to be(nil)
        end
      end
  
      it 'can run the full cycle with csoundPerformBuffer' do
        quiet_stderr do
          expect((cs = CsoundAPIRuby::CsoundLib::csoundCreate(nil)).class).to be(FFI::Pointer)
          expect((argv = FFI::Utilities.set_argv(@args)).class).to be(FFI::MemoryPointer)
          expect(res = CsoundAPIRuby::CsoundLib::csoundCompile(cs, @args.size, argv)).to eq(0)
          cnt = res = 0
          while(res == 0)
            expect(res = CsoundAPIRuby::CsoundLib::csoundPerformBuffer(cs)).to be >= 0
            cnt += 1
          end
          expect(cnt).to eq(@n_frames)
          expect(CsoundAPIRuby::CsoundLib::csoundCleanup(cs)).to be(nil)
          expect(CsoundAPIRuby::CsoundLib::csoundDestroy(cs)).to be(nil)
        end
      end

      it 'can reset the engine and perform twice in a row' do
        quiet_stderr do
          expect((cs = CsoundAPIRuby::CsoundLib::csoundCreate(nil)).class).to be(FFI::Pointer)
          expect((argv = FFI::Utilities.set_argv(@args)).class).to be(FFI::MemoryPointer)
          expect(res = CsoundAPIRuby::CsoundLib::csoundCompile(cs, @args.size, argv)).to eq(0)
          cnt = res = 0
          while(res == 0)
            expect(res = CsoundAPIRuby::CsoundLib::csoundPerformBuffer(cs)).to be >= 0
            cnt += 1
          end
          expect(cnt).to eq(@n_frames)
          expect(CsoundAPIRuby::CsoundLib::csoundReset(cs)).to be(nil)
          expect(res = CsoundAPIRuby::CsoundLib::csoundCompile(cs, @args.size, argv)).to eq(0)
          cnt = 0
          while(res == 0)
            expect(res = CsoundAPIRuby::CsoundLib::csoundPerformBuffer(cs)).to be >= 0
            cnt += 1
          end
          expect(cnt).to eq(@n_frames)
          expect(CsoundAPIRuby::CsoundLib::csoundCleanup(cs)).to be(nil)
          expect(CsoundAPIRuby::CsoundLib::csoundDestroy(cs)).to be(nil)
        end
      end

    end

  end

end
