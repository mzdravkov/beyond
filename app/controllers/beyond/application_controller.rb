#module Beyond
  class Beyond::ApplicationController < ApplicationController #ActionController::Base <- removed in order to inherit from host app's layout and session
  end
#end
