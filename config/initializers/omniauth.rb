Rails.application.middleware.use OmniAuth::Builder do
  omniauth = YAML.load_file(Rails.root + "config" + "omniauth_keys.yml")[Rails.env]
  configure do |config|
    prefix = omniauth["config"]["path_prefix"]
    if prefix
      if prefix =~ /\/$/
        prefix += "auth"
      else
        prefix += "/auth"
      end
      prefix = '/' + prefix unless prefix =~ /^\//
      Rails.logger.info "Using omniauth path prefix of #{prefix}"
      config.path_prefix = prefix
    end
  end

  omniauth["providers"].each do |provider_name, keys|
    provider provider_name.to_sym, *keys
  end
end
