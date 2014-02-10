$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "beyond/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "beyond"
  s.version     = Beyond::VERSION
  s.authors     = ["Mihail Zdravkov"]
  s.email       = ["mihail0zdravkov@gmail.com"]
  s.homepage    = "http://github.com/mzdravkov/beyond"
  s.summary     = "Deploy applications at runtime with one button click. Is it any good: yes."
  s.description = "A gem that uses docker and https://github.com/mzdravkov/kamino to deploy applications by example on the run."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"
  s.add_dependency 'plugman'
  s.add_dependency 'paperclip'
  s.add_dependency 'haml-rails'
  s.add_dependency 'devise'
  s.add_dependency 'figaro'

  s.add_development_dependency "sqlite3"
end
