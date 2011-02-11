class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:create, :failure, :unknown, :link_account, :create_account]
  def create
    if current_user
      add_authentication    
    else
      not_signed_in
    end
  end

  def index
    @authentications = current_user.authentications
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Removed authentication"
  end

  def failure
    redirect_to root_url, :error => params[:message]
  end

  def unknown
    @auth = session["devise.omniauth"]
    @user = User.new
    @user.email = @auth["user_info"]["email"]
    @user.username = @auth["user_info"]["nickname"]
    @user.display_name = @auth["user_info"]["name"]
  end

  def link_account
    user = warden.authenticate!(:scope => :user, :recall => "#{controller_path}#unknown")
    current_user.authentications.create!(@auth["provider"], @auth["uid"])
    sign_in_and_redirect user, :event => :authentication
    session["devise.omniauth"] = nil    
  end

  private

  def add_authentication
    auth = request.env["omniauth.auth"]
    current_user.authentications.find_or_create_by_provider_and_uid(auth["provider"], auth["uid"])
    redirect_to authentications_url, :notice => "Added new authentication"
  end

  def not_signed_in
    auth = request.env["omniauth.auth"]
    if @authentication = Authentication.where(:provider => auth["provider"], :uid => auth["uid"]).first
      Rails.logger.info "Logging in #{@authentication.user.email}"
      flash[:notice] = "Welcome back #{@authentication.user.display_name}"
      sign_in_and_redirect @authentication.user, :event => :authentication
    else
      session["devise.omniauth"] = auth.except("extra")
      redirect_to unknown_authentications_path
    end
  end
end
