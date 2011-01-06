Devise::OmniAuth.test_mode!

ACCESS_TOKEN = {
  :access_token => "plataformatec"
}

FACEBOOK_INFO = {
  :id => '12345',
  :link => 'http://facebook.com/user_example',
  :email => 'user@example.com',
  :first_name => 'User',
  :last_name => 'Example',
  :website => 'http://blog.plataformatec.com.br'
}

Before do
  Devise::OmniAuth.short_circuit_authorizers!
  Devise::OmniAuth.stub!(:facebook) do |b|
    b.post('/oauth/access_token') { [200, {}, ACCESS_TOKEN.to_json] }
    b.get('/me?access_token=plataformatec') { [200, {}, FACEBOOK_INFO.to_json] }
  end  
end

After do |scenario|
  Devise::OmniAuth.unshort_circuit_authorizers!
  Devise::OmniAuth.reset_stubs!
end
