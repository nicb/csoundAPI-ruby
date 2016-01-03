require_relative File.join('..', 'spec_helper')
require_relative File.join('..', 'utilities')

describe CsoundAPIRuby::Lib::Functions do

  include Spec::Utilities

  before :example do
    @csd_filename = File.join(SPEC_CSOUND_FIXTURE_PATH, 'simple.csd')
    @dur = 9.4
    @sr = 44100.0
    @kr = 441.0
    @ksmps = (@sr / @kr).ceil
    @nsamples = (@sr * @dur).ceil
    @ksmps_cycles = (@nsamples / @ksmps.to_f).ceil
    @nchnls = 1
    @frame_size = 1024 # size of a frame
    @n_frames = (@nsamples / @frame_size.to_f).ceil  # frames produced by the above file (9.4 secs @ 44100 = 1620 @frame_size-sample frames)
    @_0dBFS = 1.0
    @args = [ 'fake_csound', "-b #{@frame_size}", '--messagelevel=0', '--nosound', '--nodisplays', @csd_filename ]
  end

  context 'basic functions' do

    context 'creation/destruction functions' do

      it 'can create a csound variable' do
        quiet_stderr do
          expect((cs = CsoundAPIRuby::Lib::Functions::csoundCreate(nil)).class).to be(FFI::Pointer)
          expect(CsoundAPIRuby::Lib::Functions::csoundDestroy(cs)).to be(nil)
        end
      end
  
      it 'can do a compile cycle' do
        quiet_stderr do
          expect((cs = CsoundAPIRuby::Lib::Functions::csoundCreate(nil)).class).to be(FFI::Pointer)
          expect((argv = FFI::Utilities.set_argv(@args)).class).to be(FFI::MemoryPointer)
          expect(res = CsoundAPIRuby::Lib::Functions::csoundCompile(cs, @args.size, argv)).to eq(0)
          expect(CsoundAPIRuby::Lib::Functions::csoundDestroy(cs)).to be(nil)
        end
      end
  
      it 'can compile args' do
        quiet_stderr do
          expect((cs = CsoundAPIRuby::Lib::Functions::csoundCreate(nil)).class).to be(FFI::Pointer)
          expect((argv = FFI::Utilities.set_argv(@args)).class).to be(FFI::MemoryPointer)
          expect(res = CsoundAPIRuby::Lib::Functions::csoundCompileArgs(cs, @args.size, argv)).to eq(0)
          expect(CsoundAPIRuby::Lib::Functions::csoundCleanup(cs)).to be(nil)
          expect(CsoundAPIRuby::Lib::Functions::csoundDestroy(cs)).to be(nil)
        end
      end
  
      it 'can compile csds' do
        quiet_stderr do
          expect((cs = CsoundAPIRuby::Lib::Functions::csoundCreate(nil)).class).to be(FFI::Pointer)
          expect(res = CsoundAPIRuby::Lib::Functions::csoundCompileCsd(cs, FFI::Utilities.set_string(@csd_filename))).to eq(0)
          expect(CsoundAPIRuby::Lib::Functions::csoundCleanup(cs)).to be(nil)
          expect(CsoundAPIRuby::Lib::Functions::csoundDestroy(cs)).to be(nil)
        end
      end

      #
      # FIXME: these succeed locally but fail on travis, so we kill them for now until we know what to do
      # with them
      #
#     it 'returns the version' do
#       expect(v = fixture_syscall("#{SPEC_C_FIXTURE_PATH}/csound_version")).to be > 0
#       expect(CsoundAPIRuby::Lib::Functions::csoundGetVersion()).to eq(v)
#     end

#     it 'returns the API version' do
#       expect(v = fixture_syscall("#{SPEC_C_FIXTURE_PATH}/csound_API_version")).to be > 0
#       expect(CsoundAPIRuby::Lib::Functions::csoundGetAPIVersion()).to eq(v)
#     end

    end

    context 'performance functions' do

      it 'can run the full cycle with csoundPerformKsmps' do
        quiet_stderr do
          expect((cs = CsoundAPIRuby::Lib::Functions::csoundCreate(nil)).class).to be(FFI::Pointer)
          expect((argv = FFI::Utilities.set_argv(@args)).class).to be(FFI::MemoryPointer)
          expect(res = CsoundAPIRuby::Lib::Functions::csoundCompile(cs, @args.size, argv)).to eq(0)
          cnt = res = 0
          while(res == 0)
            expect(res = CsoundAPIRuby::Lib::Functions::csoundPerformKsmps(cs)).to be >= 0
            cnt += 1
          end
          expect(cnt).to eq(@ksmps_cycles)
          expect(CsoundAPIRuby::Lib::Functions::csoundCleanup(cs)).to be(nil)
          expect(CsoundAPIRuby::Lib::Functions::csoundDestroy(cs)).to be(nil)
        end
      end
  
      it 'can run the full cycle with csoundPerform' do
        quiet_stderr do
          expect((cs = CsoundAPIRuby::Lib::Functions::csoundCreate(nil)).class).to be(FFI::Pointer)
          expect((argv = FFI::Utilities.set_argv(@args)).class).to be(FFI::MemoryPointer)
          expect(res = CsoundAPIRuby::Lib::Functions::csoundCompile(cs, @args.size, argv)).to eq(0)
          expect(res = CsoundAPIRuby::Lib::Functions::csoundPerform(cs)).to eq(2)
          expect(CsoundAPIRuby::Lib::Functions::csoundCleanup(cs)).to be(nil)
          expect(CsoundAPIRuby::Lib::Functions::csoundDestroy(cs)).to be(nil)
        end
      end
  
      it 'can run the full cycle with csoundPerformBuffer' do
        quiet_stderr do
          expect((cs = CsoundAPIRuby::Lib::Functions::csoundCreate(nil)).class).to be(FFI::Pointer)
          expect((argv = FFI::Utilities.set_argv(@args)).class).to be(FFI::MemoryPointer)
          expect(res = CsoundAPIRuby::Lib::Functions::csoundCompile(cs, @args.size, argv)).to eq(0)
          cnt = res = 0
          while(res == 0)
            expect(res = CsoundAPIRuby::Lib::Functions::csoundPerformBuffer(cs)).to be >= 0
            cnt += 1
          end
          expect(cnt).to eq(@n_frames)
          expect(CsoundAPIRuby::Lib::Functions::csoundCleanup(cs)).to be(nil)
          expect(CsoundAPIRuby::Lib::Functions::csoundDestroy(cs)).to be(nil)
        end
      end

      it 'can reset the engine and perform twice in a row' do
        quiet_stderr do
          expect((cs = CsoundAPIRuby::Lib::Functions::csoundCreate(nil)).class).to be(FFI::Pointer)
          expect((argv = FFI::Utilities.set_argv(@args)).class).to be(FFI::MemoryPointer)
          expect(res = CsoundAPIRuby::Lib::Functions::csoundCompile(cs, @args.size, argv)).to eq(0)
          cnt = res = 0
          while(res == 0)
            expect(res = CsoundAPIRuby::Lib::Functions::csoundPerformBuffer(cs)).to be >= 0
            cnt += 1
          end
          expect(cnt).to eq(@n_frames)
          expect(CsoundAPIRuby::Lib::Functions::csoundReset(cs)).to be(nil)
          expect(res = CsoundAPIRuby::Lib::Functions::csoundCompile(cs, @args.size, argv)).to eq(0)
          cnt = 0
          while(res == 0)
            expect(res = CsoundAPIRuby::Lib::Functions::csoundPerformBuffer(cs)).to be >= 0
            cnt += 1
          end
          expect(cnt).to eq(@n_frames)
          expect(CsoundAPIRuby::Lib::Functions::csoundCleanup(cs)).to be(nil)
          expect(CsoundAPIRuby::Lib::Functions::csoundDestroy(cs)).to be(nil)
        end
      end

    end

    context 'attributes' do

      it 'returns the audio sample rate' do
        quiet_stderr do
          csound_perform(@args) { |cs| expect(CsoundAPIRuby::Lib::Functions::csoundGetSr(cs)).to eq(@sr) }
        end
      end

      it 'returns the control sample rate' do
        quiet_stderr do
          csound_perform(@args) { |cs| expect(CsoundAPIRuby::Lib::Functions::csoundGetKr(cs)).to eq(@kr) }
        end
      end

      it 'returns the ksmps' do
        quiet_stderr do
          csound_perform(@args) { |cs| expect(CsoundAPIRuby::Lib::Functions::csoundGetKsmps(cs)).to eq(@ksmps) }
        end
      end

      it 'returns the number of channels' do
        quiet_stderr do
          csound_perform(@args) { |cs| expect(CsoundAPIRuby::Lib::Functions::csoundGetNchnls(cs)).to eq(@nchnls) }
        end
      end

      it 'returns the number of input channels' do
        quiet_stderr do
          csound_perform(@args) { |cs| expect(CsoundAPIRuby::Lib::Functions::csoundGetNchnlsInput(cs)).to eq(@nchnls) }
        end
      end

      it 'returns the number of 0 dBFS' do
        quiet_stderr do
          csound_perform(@args) { |cs| expect(CsoundAPIRuby::Lib::Functions::csoundGet0dBFS(cs)).to eq(@_0dBFS) }
        end
      end

      it 'returns the current time in samples' do
        quiet_stderr do
          csound_perform(@args) do
            |cs|
            res = 0
            cnt = 0
            while(res == 0)
              expect(res = CsoundAPIRuby::Lib::Functions::csoundPerformBuffer(cs)).to be >= 0
              if (res == 0) # the last frame does not round
                cnt += @frame_size
                rcnt = ((cnt / @ksmps.to_f).ceil * @ksmps) # we must round this number to the k-samples
                expect(CsoundAPIRuby::Lib::Functions::csoundGetCurrentTimeSamples(cs)).to eq(rcnt)
              else # calculate the end
                expect(CsoundAPIRuby::Lib::Functions::csoundGetCurrentTimeSamples(cs)).to eq(((@dur * @sr) / @ksmps.to_f).floor * @ksmps)
              end
            end
          end
        end
      end

      it 'returns the size of csound\'s MYFLT' do
        quiet_stderr do
          csound_perform(@args) { |cs| expect(CsoundAPIRuby::Lib::Functions::csoundGetSizeOfMYFLT(cs)).to eq(CsoundAPIRuby::Lib::Data::MYFLT.size) }
        end
      end

      it 'is able to set and retrieve some host data' do
        quiet_stderr do
          host_data_string = 'test host data'
          csound_perform(@args) do
            |cs|
            expect((hdp = FFI::Utilities.set_string(host_data_string)).class).to be(FFI::MemoryPointer)
            expect(CsoundAPIRuby::Lib::Functions::csoundSetHostData(cs, hdp)).to eq(nil)
            expect((rhdp = CsoundAPIRuby::Lib::Functions::csoundGetHostData(cs)).class).to be(FFI::Pointer)
            expect(rhdp.read_string).to eq(host_data_string)
          end
        end
      end

      it 'is able to set an extra option on the fly' do
        quiet_stderr do
          new_0dBFS = 4.0
          opt = "--0dbfs=#{new_0dBFS}"
          csound_init do
            |cs|
            expect((opt_p = FFI::Utilities.set_string(opt)).class).to be(FFI::MemoryPointer)
            expect(CsoundAPIRuby::Lib::Functions::csoundSetOption(cs, opt_p)).to eq(0)
            expect(res = CsoundAPIRuby::Lib::Functions::csoundCompileArgs(cs, @args.size, FFI::Utilities.set_argv(@args))).to eq(0)
            expect(CsoundAPIRuby::Lib::Functions::csoundGet0dBFS(cs)).to eq(new_0dBFS)
          end
        end
      end

      it 'is able to set and retrieve the debug flag' do
        quiet_stderr do
          debug_value = 1
          csound_perform(@args) do
            |cs|
            expect(CsoundAPIRuby::Lib::Functions::csoundSetDebug(cs, debug_value)).to eq(nil)
            expect(CsoundAPIRuby::Lib::Functions::csoundGetDebug(cs)).to eq(debug_value)
          end
        end
      end

    end

  end

end
