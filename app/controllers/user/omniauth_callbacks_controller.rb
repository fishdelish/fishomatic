class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def get_oauth_data
    env["omniauth.auth"]['extra']['user_hash']
  end

  def facebook
    Rails.logger.info("Facebook login")
    @user = User.find_by_facebook(get_oauth_data['email'])
    if @user.persisted?
      flash[:notice] = "Successfully signed in with Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:error] = "Could not sign in with facebook"
      redirect_to root_url
    end
  end

  def twitter
    Rails.logger.info("Twitter login")
    @user = User.find_by_twitter(get_oauth_data["screen_name"] + "@twitter.com")
    if @user.persisted?
      flash[:notice] = "Successfully signed in with Twitter"
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:error] = "Could not sign in with twitter"
      redirect_to root_url
    end
  end

  protected

  def after_omniauth_failure_path_for(scope)
    root_url
  end 
end
