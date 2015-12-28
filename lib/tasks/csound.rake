#
# Csound library related tasks
#
namespace :csound do

  EXT_PATH = File.join('.', 'ext')
  BUILD_DIR = File.join(EXT_PATH, 'cs6make')
  STAMP_FILE = File.join(EXT_PATH, '.csound_library_built')

  desc 'Build the csound library (requires cmake)'
  task :build => STAMP_FILE

  file STAMP_FILE => BUILD_DIR do
    Rake::Task['csound:build:force:build'].invoke
  end

  file BUILD_DIR do
    mkdir_p BUILD_DIR
  end

  namespace :build do
    namespace :force do

      desc 'Force build the csound library (requires cmake)'
      task :build => 'csound:clean' do
        build_csound
      end

      desc 'Force build the csound library (requires cmake) with debugging symbols'
      task :debug => 'csound:clean' do
        build_csound('-DCMAKE_BUILD_TYPE=Debug')
      end

    end
  end

  desc 'clean the csound library build'
  task :clean do
    [BUILD_DIR, STAMP_FILE].each { |fh| rm_rf fh }
  end

  def build_csound(flags = '')
    Rake::Task[BUILD_DIR].execute
    cd BUILD_DIR do
      sh "cmake #{flags} ../csound; make -j6"
    end
    touch STAMP_FILE
  end

end
