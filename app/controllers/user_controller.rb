class UserController < ApplicationController
  before_filter :authenticate_user!
  def index
  end
  def update
    current_user.update_attributes(params[:user])
    if current_user.save
      unless params[:user][:password].blank?
        sign_in(current_user, :bypass => true)
      end
      flash[:notice] = "Changes have been made!"
      redirect_to current_user_path
    else
      render "index"
    end
  end
end
