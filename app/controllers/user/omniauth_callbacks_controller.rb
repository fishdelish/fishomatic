class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def get_oauth_data
    env["omniauth.auth"]['extra']['user_hash']
  end

  def facebook
    Rails.logger.info("Facebook login")
    @user = User.find_by_facebook(get_oauth_data['email'])
    sign_in_and_redirect @user, :event => :authentication
  end 
end
