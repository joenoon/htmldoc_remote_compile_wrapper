require 'mkmf'
require 'fileutils'
require 'open-uri'

root = File.expand_path('../..', __FILE__)
src_dir = File.join(root, 'src')
tgz_filename = "htmldoc.tgz"
tgz_file = File.join(src_dir, tgz_filename)

FileUtils.rm_rf src_dir
FileUtils.mkdir src_dir

source_url = "http://ftp.easysw.com/pub/htmldoc/1.8.27/htmldoc-1.8.27-source.tar.gz"

puts "===> Downloading: #{source_url} to #{tgz_file}"

open(tgz_file, "wb") do |file|  
  file.print open(source_url).read
end

Dir.chdir(src_dir) do
  puts "===> Changing to directory: #{src_dir}"
  puts "===> Extracting #{tgz_filename}"
  system "tar xzf #{tgz_filename} --strip-components=1"
  puts "===> Configuring with prefix: #{root}"
  system "./configure --prefix=#{root}"
  puts "===> Building..."
  system "make"
  puts "===> Installing..."
  system "make install"
  puts "===> Cleaning up..."
  system "make clean"
end

FileUtils.rm_rf src_dir

puts "===> Done compiling htmldoc."
