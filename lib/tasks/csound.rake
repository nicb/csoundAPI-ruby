#
# Csound library related tasks
#
namespace :csound do

  EXT_PATH = File.expand_path(File.join(['..'] * 3, 'ext'), __FILE__)
  BUILD_DIR = 'cs6make'
  STAMP_FILE = File.join('.', 'ext', '.csound_library_built')

  desc 'Build the csound library (requires cmake)'
  task :build => STAMP_FILE

  file STAMP_FILE => './ext/cs6make' do
    Rake::Task['csound:build:force:build'].invoke
  end

  namespace :build do
    namespace :force do

      desc 'Force build the csound library (requires cmake)'
      task :build => 'csound:clean' do
        mkdir_p File.join(EXT_PATH, BUILD_DIR)
        build_csound
      end

      desc 'Force build the csound library (requires cmake) with debugging symbols'
      task :debug => 'csound:clean' do
        mkdir_p File.join(EXT_PATH, BUILD_DIR)
        build_csound('-DCMAKE_BUILD_TYPE=Debug')
      end

    end
  end

  desc 'clean the csound library build'
  task :clean do
    rm_rf File.join(EXT_PATH, BUILD_DIR), STAMP_FILE
  end

  def build_csound(flags = '')
    cd File.join(EXT_PATH, BUILD_DIR) do
      sh "cmake #{flags} ../csound; make -j6"
    end
    touch STAMP_FILE
  end

end
