Rails.application.config.middleware.use OmniAuth::Builder do
  omniauth = YAML.load_file(Rails.root + "config" + "omniauth_keys.yml")[Rails.env]
  configure do |config|
    config.path_prefix = omniauth["config"]["path_prefix"] if omniauth["config"]
  end

  omniauth["providers"].each do |provider_name, keys|
    provider provider_name.to_sym, *keys
  end
end
