Gem::Specification.new do |gem|
  gem.authors       = ["Krishpranav"]
  gem.email         = ["krisna.pranav@gmail.com"]
  gem.description   = %q{ruby mail framework}
  gem.summary       = %q{ruby mail framework}
  gem.homepage      = "http://github.com/krishpranav/rubymail"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "rubymail"
  gem.require_paths = ["lib"]
  gem.version       = "0.11"

  gem.add_development_dependency(%q<rspec>, [">= 2"])
  gem.add_development_dependency(%q<pry>, [">= 0"])
  gem.add_development_dependency(%q<webmock>, [">= 2"])
end