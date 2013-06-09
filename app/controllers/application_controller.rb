class ApplicationController < ActionController::Base
  protect_from_forgery
  include Mobylette::RespondToMobileRequests
  mobylette_config do |config|
    config[:skip_xhr_request]=false
  end
end
