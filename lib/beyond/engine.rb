require 'haml-rails'
require 'figaro'
require 'plugman'

log     = StringIO.new("")
# loads event plugins (the lambda has arg because plugman needs it for loggin)
loader  = ->(a) { Dir.glob('./event_plugins/*.rb').each {|f| require f} }
# define plugins constant
PLUGINS = Plugman.new(loader: loader, logger: Logger.new(log))
PLUGINS.load_plugins

module Beyond
  class Engine < ::Rails::Engine
    isolate_namespace Beyond
  end
end
