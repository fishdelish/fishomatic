class User::SessionsController < Devise::SessionsController

  def link_account
    @auth = session["devise.omniauth"]
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    resource.authentications.find_or_create_by_provider_and_uid(@auth["provider"], @auth["uid"])
    session["devise.omniauth"] = nil
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => redirect_location(resource_name, resource)
  end
end
