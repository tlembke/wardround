class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :check_permissions, :only => [:new, :create, :cancel]
  skip_before_filter :require_no_authentication
  before_filter :check_format
  def check_format
    request.format = "html"
  end
 
  def check_permissions
    authorize! :create, resource
  end
end