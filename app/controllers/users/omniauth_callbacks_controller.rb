class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # def facebook
  #   # You need to implement the method below in your model
  #   @user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)
  # 
  #   if @user.persisted?
  #     flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
  #     sign_in_and_redirect @user, :event => :authentication
  #   else
  #     session["devise.facebook_data"] = env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end
  # def twitter
  #   # You need to implement the method below in your model
  #   @user = User.find_for_twitter_oauth(env["omniauth.auth"], current_user)
  #   if !@user
  #     session["username"] = env["omniauth.auth"]['extra']['user_hash']['screen_name']
  #     redirect_to new_user_registration_url
  #   elsif @user.persisted?
  #     flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
  #     sign_in_and_redirect @user, :event => :authentication
  #   else
  #     session["devise.twitter_data"] = env["omniauth.auth"]
  #     session["username"] = env["omniauth.auth"]['extra']['user_hash']['screen_name']
  #     redirect_to new_user_registration_url
  #   end
  # end
  def method_missing(provider)
    if !User.omniauth_providers.index(provider).nil?
      #omniauth = request.env["omniauth.auth"]
      omniauth = env["omniauth.auth"]
    
      if current_user #or User.find_by_email(auth.recursive_find_by_key("email"))
        current_user.user_tokens.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
         flash[:notice] = "Authentication successful"
         redirect_to edit_user_registration_path
      else
    
      authentication = UserToken.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
   
        if authentication
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
          sign_in_and_redirect(:user, authentication.user)
          #sign_in_and_redirect(authentication.user, :event => :authentication)
        else
          
          #create a new user
          unless omniauth.recursive_find_by_key("email").blank?
            user = User.find_or_initialize_by_email(:email => omniauth.recursive_find_by_key("email"))
          else
            user = User.new
          end
          
          user.apply_omniauth(omniauth)
          #user.confirm! #unless user.email.blank?

          if user.save
            flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
            sign_in_and_redirect(:user, user)
          else
            Rails.logger.error "Could not create user...#{user.errors.inspect}"
            session[:omniauth] = omniauth.except('extra')
            redirect_to new_user_registration_url
          end
        end
      end
    end
  end
end