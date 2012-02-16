require_relative "../lib/frank"

require "cutest"
require "capybara/dsl"

class Cutest::Scope
  include Capybara::DSL
end
