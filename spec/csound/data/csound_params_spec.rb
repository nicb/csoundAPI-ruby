require_relative File.join(['..'] * 2, 'spec_helper')
require_relative File.join(['..'] * 2, 'utilities')

describe CsoundAPIRuby::Lib::Data::CsoundParams do

  include Spec::Utilities

  it 'cannot be created by itself' do
    quiet_stderr do
      expect { CsoundAPIRuby::Lib::Data::CsoundParams.new }.to raise_error(NoMethodError)
    end
  end

  it 'has the correct calculated size' do
    system("#{SPEC_C_FIXTURE_PATH}/sizeof_CSOUND_PARAMS")
    expect(c_size = $?.exitstatus).to be > 0
    expect(CsoundAPIRuby::Lib::Data::CsoundParams.size).to eq(c_size)
  end

  it 'is created through the :create class method' do
    quiet_stderr do
      csound_init do
        |cs|
        expect((CsoundAPIRuby::Lib::Data::CsoundParams.create(cs)).class).to be(CsoundAPIRuby::Lib::Data::CsoundParams)
      end
    end
  end

  it 'is able to read and write on all params' do
    quiet_stderr do
      csound_init do
        |cs|
        expect((cs_params = CsoundAPIRuby::Lib::Data::CsoundParams.create(cs)).class).to be(CsoundAPIRuby::Lib::Data::CsoundParams)
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

end
