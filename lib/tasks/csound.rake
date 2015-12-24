#
# Csound library related tasks
#
namespace :csound do

  EXT_PATH = File.expand_path(File.join(['..'] * 3, 'ext'), __FILE__)
  BUILD_DIR = 'cs6make'

  desc 'Build the csound library (requires cmake)'
  task :build do
    mkdir_p File.join(EXT_PATH, BUILD_DIR)
    sh("cd #{File.join(EXT_PATH, BUILD_DIR)}; cmake ../csound; make -j6") 
  end

  desc 'clean the csound library build'
  task :clean do
    rm_rf File.join(EXT_PATH, BUILD_DIR)
  end

end
