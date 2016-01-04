require 'spec_helper'
require_relative File.join(['..'] * 2, 'utilities')

describe CsoundAPIRuby::Lib::Data::CsoundParams do

  include Spec::Utilities

  before :example do
    @csd_filename = File.join(SPEC_CSOUND_FIXTURE_PATH, 'simple.csd')
    @frame_size = 1024 # size of a frame
    @args = [ 'fake_csound', "-b #{@frame_size}", '--messagelevel=0', '--nosound', '--nodisplays', @csd_filename ]
  end

  it 'cannot be created by itself' do
    quiet_stderr do
      expect { CsoundAPIRuby::Lib::Data::CsoundParams.new }.to raise_error(NoMethodError)
    end
  end

  it 'has the correct calculated size' do
    expect(v = fixture_syscall("#{SPEC_C_FIXTURE_PATH}/sizeof_CSOUND_PARAMS")).to be > 0
    expect(CsoundAPIRuby::Lib::Data::CsoundParams.size).to eq(v)
  end

  it 'is created through the :create class method' do
    quiet_stderr do
      csound_init do
        |cs|
        expect((CsoundAPIRuby::Lib::Data::CsoundParams.create()).class).to be(CsoundAPIRuby::Lib::Data::CsoundParams)
      end
    end
  end

  it 'is able to read and write on all params' do
    quiet_stderr do
      csound_init do
        |cs|
        expect((cs_params = CsoundAPIRuby::Lib::Data::CsoundParams.create()).class).to be(CsoundAPIRuby::Lib::Data::CsoundParams)
        cs_params.layout.members.each do
          |m|
          w_m = (m.to_s + '=').to_sym
          expect(cs_params.respond_to?(m)).to be(true)          # read
          expect(cs_params.respond_to?(w_m)).to be(true)         # write
          value = cs_params.send(m)
          expect(value.nil? || value.is_a?(Numeric)).to be(true)
          value = cs_params.send(w_m, value)
          expect(value.nil? || value.is_a?(Numeric)).to be(true)
        end
      end
    end
  end

  it 'can use the proper csound setters/getters' do
    quiet_stderr do
      csound_init do
        |cs|
        expect((cs_params = CsoundAPIRuby::Lib::Data::CsoundParams.create()).class).to be(CsoundAPIRuby::Lib::Data::CsoundParams)
        expect(CsoundAPIRuby::Lib::Functions.csoundGetParams(cs, cs_params)).to eq(nil)
        expect(dbg_mode = cs_params.debug_mode).to be >= (0)
        expect(new_dbg_mode = cs_params.debug_mode = dbg_mode + 1).to eq(dbg_mode + 1)
        expect(CsoundAPIRuby::Lib::Functions.csoundSetParams(cs, cs_params)).to eq(nil)
        expect(CsoundAPIRuby::Lib::Functions.csoundGetDebug(cs)).to eq(new_dbg_mode)
      end
    end
  end

end
