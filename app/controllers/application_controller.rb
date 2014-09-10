class ApplicationController < ActionController::Base
 


  before_filter :force_mobile
  include Mobylette::RespondToMobileRequests
  mobylette_config do |config|
    config[:skip_xhr_request]=false
  end
  before_filter :authenticate_user!
  
  rescue_from CanCan::AccessDenied do |exception|
     flash[:error] = exception.message
     redirect_to root_url
   end

  def after_sign_in_path_for(resource)
    root_path
  end


  private 

  def after_sign_out_path_for(resource)
     root_path
   end
   
  def force_mobile

    session[:mobylette_override] = :force_mobile
  end


  
end
