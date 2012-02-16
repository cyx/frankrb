Gem::Specification.new do |s|
  s.name              = "frankrb"
  s.version           = "0.0.1"
  s.summary           = "A proof of concept originally conceived while writing a blog post."
  s.description       = "Frank tries to demonstrate how to write a basic Sinatra-ish clone."
  s.authors           = ["Cyril David"]
  s.email             = ["me@cyrildavid.com"]
  s.homepage          = "http://github.com/cyx/frankrb"

  s.files = Dir[
    "LICENSE",
    "README",
    "rakefile",
    "lib/**/*.rb",
    "*.gemspec",
    "test/*.*"
  ]

  s.add_dependency "rack"
  s.add_development_dependency "cutest"
  s.add_development_dependency "capybara"
end
