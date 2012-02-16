require_relative "helper"

class Blog < Frank
  get "/" do
    "Main Blog"
  end

  get "/post/:id" do |id|
    "Displaying post #{id}"
  end
end

class Support < Frank
  get "/" do
    "Main Support Site"
  end

  get "/submit" do
    "<form method='post'><textarea name='issue'></textarea>" +
    "<input type='submit' name='submit' value='Help'></form>"
  end

  post "/submit" do
    "Received issue: %s" % request.params["issue"]
  end
end

class Docs < Frank
  get "/" do
    "We're here to help!"
  end

  get "/download" do
    "Download our documentation in PDF or read it online!"
  end
end

class Home < Frank
  get "/" do
    "Homepage"
  end

  get "/about" do
    "About"
  end
end

def helloapp
  builder = Rack::Builder.new

  builder.map "/blog" do
    run Blog
  end

  builder.map "/docs" do
    run Docs
  end

  builder.map "/support" do
    run Support
  end

  builder.run Home

  return builder.to_app
end

prepare do
  Capybara.app = helloapp
end

scope do
  test "home" do
    visit "/"
    assert_equal "Homepage", page.source
  end

  test "about" do
    visit "/about"
    assert_equal "About", page.source
  end

  test "docs" do
    visit "/docs"
    assert_equal "We're here to help!", page.source

    # Also works with trailing slashes
    visit "/docs/"
    assert_equal "We're here to help!", page.source

    # Also works with trailing slash + a query string
    visit "/docs/?foo=bar"
    assert_equal "We're here to help!", page.source
  end

  test "support" do
    visit "/support/submit"

    fill_in "issue", with: "I need help!"
    click_button "Help"

    assert_equal "Received issue: I need help!", page.source
  end

  test "blog" do
    visit "/blog/post/1234/"
    assert_equal "Displaying post 1234", page.source
  end
end
