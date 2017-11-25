$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "presenter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "presenter-rails"
  s.version     = Presenter::VERSION
  s.authors     = ["Sam Sargent", "Finn Francis"]
  s.email       = ["samsarge@hotmail.co.uk", "finnfrancis123@gmail.com"]
  s.homepage    = "https://github.com/samsarge/presenter-rails"
  s.summary     = "Easily implement the presenter design pattern in rails projects."
  s.description = "Keep code neat and abstract view & presenter logic. Adding a simple separation of concerns when creating your models with an easy API."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]


  s.add_development_dependency "rails", "~> 5.0.2"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "pry"
end
