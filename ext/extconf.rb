require 'mkmf'

root = File.expand_path('../..', __FILE__)
src_dir = File.join(root, 'src')
bin_dir = File.join(root, 'bin')
tgz_filename = "htmldoc-1.8.28-source.tar.gz"
tgz_file = File.join(src_dir, tgz_filename)
patch_filename = "htmldoc-1.8.28.patch"

Dir.chdir(src_dir) do
  puts "===> Changing to directory: #{src_dir}"
  puts "===> Extracting #{tgz_filename}"
  system "tar xzf #{tgz_filename} --strip-components=1"
  puts "===> Patching"
  system "patch -p0 <#{patch_filename}"
  puts "===> Configuring with prefix: #{root}"
  system "./configure --prefix=#{root}"
  puts "===> Building..."
  system "make"
  puts "===> Installing..."
  system "make install"
  raise "make install failed!" unless File.exist?(bin_dir)
  puts "===> Cleaning up..."
  system "make clean"
end

puts "===> Done compiling htmldoc."

create_makefile 'htmldoc_remote_compile_wrapper'
