$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "commands_workshop/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "commands_workshop"
  s.version     = CommandsWorkshop::VERSION
  s.authors     = ["Benjamin Roth"]
  s.email       = ["benjamin@rubyist.fr"]
  s.homepage    = "https://github.com/apneadiving/rails-conf-workshop"
  s.summary     = "TBD: Summary of CommandsWorkshop."
  s.description = "TBD: Description of CommandsWorkshop."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 5.0.2"
  s.add_dependency "waterfall"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'database_cleaner'
end
