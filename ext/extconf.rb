require 'mkmf'

root = File.expand_path('../..', __FILE__)
src_dir = File.join(root, 'src')
bin_dir = File.join(root, 'bin')
tgz_filename = "htmldoc-1.8.27-source.tar.gz"
tgz_file = File.join(src_dir, tgz_filename)
# Fixes building with libpng-1.5, from upstream svn r1668 via Fedora
# Remove at version 1.8.28. cf. https://github.com/mxcl/homebrew/issues/15915
patch_filename = "htmldoc-1.8.27-libpng15.patch"
patch_file = File.join(src_dir, patch_filename)

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
