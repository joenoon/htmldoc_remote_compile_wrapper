require 'mkmf'
require 'fileutils'
require 'open-uri'

root = File.expand_path('../..', __FILE__)
src_dir = File.join(root, 'src')
bin_dir = File.join(root, 'bin')
tgz_filename = "htmldoc.tgz"
tgz_file = File.join(src_dir, tgz_filename)
patch_file = File.join(src_dir, "libpng_patch")

FileUtils.rm_rf src_dir
FileUtils.mkdir src_dir

source_url = "https://joenoon-public.s3.amazonaws.com/htmldoc-1.8.27-source.tar.gz"
# Fixes building with libpng-1.5, from upstream svn r1668 via Fedora
# Remove at version 1.8.28. cf. https://github.com/mxcl/homebrew/issues/15915
patch_url = "https://gist.github.com/joenoon/5733730/raw/4da9eca3b0ba0f3d1303769bdc408729b8654632/gistfile1.diff"

puts "===> Downloading: #{source_url} to #{tgz_file}"

open(tgz_file, "wb") do |file|  
  file.print open(source_url).read
end

open(patch_file, "wb") do |file|  
  file.print open(patch_url).read
end

Dir.chdir(src_dir) do
  puts "===> Changing to directory: #{src_dir}"
  puts "===> Extracting #{tgz_filename}"
  system "tar xzf #{tgz_filename} --strip-components=1"
  puts "===> Patching"
  system "patch -p0 <libpng_patch"
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

FileUtils.rm_rf src_dir

puts "===> Done compiling htmldoc."

create_makefile 'htmldoc_remote_compile_wrapper'
