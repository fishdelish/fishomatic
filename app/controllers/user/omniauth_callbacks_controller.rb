class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
  end

  def twitter
  end

  protected

  def after_omniauth_failure_path_for(scope)
    root_url
  end 
end
