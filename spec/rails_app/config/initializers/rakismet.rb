module RailsApp
  class Application < Rails::Application
    config.rakismet.key = 'xxx'
    config.rakismet.url = 'http://yourdomain.com/'
  end
end