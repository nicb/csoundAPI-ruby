require 'spec_helper'

def quiet
  #
  # we want to shut off STDERR to avoid seeing csound's output
  #
  stderr_backup = $stderr.dup
  $stderr.reopen('/dev/null', 'w')

  yield

  #
  # resume normal STDERR
  #
  $stderr = stderr_backup.dup
end

describe CsoundAPIRuby::CsoundLib do

  it 'runs the basic csound API interface' do
    quiet do
      expect((p = CsoundAPIRuby::CsoundLib::csoundCreate(0)).class).to be(FFI::Pointer)
    end
  end

end
