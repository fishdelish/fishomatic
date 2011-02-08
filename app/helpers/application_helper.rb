module ApplicationHelper
  def omniauth_authorise_path(provider)
    prefix = OmniAuth.config.path_prefix
    "#{prefix}/#{provider}"
  end
end
