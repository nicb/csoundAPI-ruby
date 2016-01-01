require 'spec_helper'

describe 'CsoundAPIRuby::Lib::Data::MYFLT' do

  before :example do
    @arg_1, @arg_2, @arg_3 = 23, 23.2323, 123456789
  end

  it 'should have the same size as the C typedef' do
    system("#{SPEC_C_FIXTURE_PATH}/sizeof_MYFLT")
    expect(c_size = $?.exitstatus).to be > 0
    expect(CsoundAPIRuby::Lib::Data::MYFLT.size).to eq(c_size)
  end

  module CsoundAPIRuby::Lib::Data::Test

    extend FFI::Library

    class MYFLTTest < FFI::Utilities::Struct

      layout :this, :char,
             :that, :MYFLT,
             :the_other, :int

      attr_accessor layout.members

    end

  end

  it 'should read and write properly' do
    expect((mt = CsoundAPIRuby::Lib::Data::Test::MYFLTTest.create()).class).to be(CsoundAPIRuby::Lib::Data::Test::MYFLTTest)
    expect(mt.this = @arg_1).to eq(@arg_1)
    expect(mt.that = @arg_2).to eq(@arg_2)
    expect(mt.the_other = @arg_3).to eq(@arg_3)
    #
    # let's read them back one more time
    #
    expect(mt.this).to eq(@arg_1)
    expect(mt.that).to eq(@arg_2)
    expect(mt.the_other).to eq(@arg_3)
  end

end
