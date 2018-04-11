lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fortytwoish/version'

Gem::Specification.new do |spec|
  spec.name          = 'fortytwoish'
  spec.version       = Fortytwoish::VERSION
  spec.authors       = ['Davor Babić']
  spec.email         = ['davor@davor.se']

  spec.summary       = %q{For sending SMS using Fortytwo API}
  spec.description   = %q{Simple gem that implements sending SMS using Fortytwo API.}
  spec.homepage      = 'https://github.com/rushplay/fortytwoish'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'webmock'
end
