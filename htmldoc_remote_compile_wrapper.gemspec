# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Joe Noon"]
  gem.email         = ["joenoon@gmail.com"]
  gem.description   = %q{Compile htmldoc binary}
  gem.summary       = %q{Suitable for environments like Heroku.  Downloads the htmldoc source and compiles using the native extension hook upon gem installation.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.extensions    = ['ext/extconf.rb']
  gem.name          = "htmldoc_remote_compile_wrapper"
  gem.require_paths = ["lib"]
  gem.version       = "0.3"
end
