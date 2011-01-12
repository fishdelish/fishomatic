class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    Rails.logger.info("Facebook login")
    User.create!
  end 
end
