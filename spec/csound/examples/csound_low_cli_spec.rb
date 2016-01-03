require 'spec_helper'
require_relative File.join(['..'] * 2, 'utilities')

describe 'csound_low_cli.rb' do

  include Spec::Utilities

  EXAMPLE_PATH = File.expand_path(File.join(['..'] * 4, 'share', 'doc', 'examples'), __FILE__)

  before :example do
    @csd_filename = File.join(SPEC_CSOUND_FIXTURE_PATH, 'simple.csd')
    @frame_size = 1024 # size of a frame
    @args = [ "-b #{@frame_size}", '--messagelevel=0', '--nosound', '--nodisplays', @csd_filename ]
  end

  it 'runs without problems' do
    quiet_stderr do
      command = EXAMPLE_PATH + '/csound_low_cli.rb' + ' ' + @args.join(' ')
      system(command)
      expect($?.exitstatus).to eq(0)
    end
  end

end
