class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :force_mobile
  include Mobylette::RespondToMobileRequests
  mobylette_config do |config|
    config[:skip_xhr_request]=false
  end
  

  private 

  def force_mobile
    session[:mobylette_override] = :force_mobile
  end
  
end
