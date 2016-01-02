require_relative File.join('..', 'spec_helper')
require_relative File.join('..', 'utilities')

describe 'CsoundAPIRuby::Lib::Data' do

  include Spec::Utilities

  it 'should say something if the struct files cannot be loaded' do
    #
    # get all the ffi files, erase them and then load the 'data.rb' file:
    # this should raise a LoadError exception
    #
    ffi_struct_files = Dir.glob(File.join(CsoundAPIRuby::Lib::Data::PATH, '**', '*.rb.ffi'))
    ffi_struct_files.each do
      |rb_struct_file|
      rb_struct_file.sub!(/.ffi\Z/, '')
      File.unlink(rb_struct_file)
    end
    path = CsoundAPIRuby::Lib::Data::PATH
    #
    # undef the PATH constant
    #
    undef_constant(:'CsoundAPIRuby::Lib::Data::PATH')
    #
    # remove 'csound_params.rb' from the require cache (to generate the load error)
    #
    raise LoadError unless clear_require_cache('data.rb')
    raise LoadError unless clear_require_cache('csound_params.rb')
    #
    # now let's do the load expecting the exception
    #
    quiet_stderr do
      expect { load File.join(path, '..', 'data.rb') }.to raise_error(LoadError)
    end
  end

  #
  # <tt>undef_constant(const)</tt>
  #
  # undef a constant within a given +module+ (if defined)
  # +const+ is a symbol representing a (possibly defined) const
  #
  def undef_constant(const)
    parts = const.to_s.split('::')
    mod_string = parts[0..-2].join('::')          # get the module part
    mod = Module.class_eval(mod_string)
    const_sym = parts[-1].to_sym
    mod.send(:remove_const, const_sym) if mod.const_defined?(const_sym)
  end

  #
  # <tt>clear_require_cache(rq_file)</tt>
  #
  def clear_require_cache(rq_file)
    cache_files = $LOADED_FEATURES.grep(/\/#{rq_file}\Z/)
    cache_files.each { |cf| $LOADED_FEATURES.delete(cf) }
    true
  end

end
