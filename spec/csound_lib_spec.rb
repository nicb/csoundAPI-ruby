require 'spec_helper'

describe CsoundAPIRuby::CsoundLib do

  it 'runs the basic csound API interface' do
    #
    # we want to shut off STDERR to avoid seeing csound's output
    #
    stderr_backup = $stderr.dup
    $stderr.reopen('/dev/null', 'w')

    expect((p = CsoundAPIRuby::CsoundLib::csoundCreate(0)).class).to be(FFI::Pointer)

    #
    # resume normal STDERR
    #
    $stderr = stderr_backup.dup
  end

end
