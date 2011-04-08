class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  protected
  def after_sign_in_path_for(resource)
    if session.include?(:redirect_after_sign_in_url)
      session.delete(:redirect_after_sign_in_url)
    else
      super
    end
  end
end
