class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    Logger.info("Facebook login")
    User.create!
  end 
end
