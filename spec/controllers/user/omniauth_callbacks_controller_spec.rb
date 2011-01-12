require 'spec_helper'

describe User::OmniauthCallbacksController do
  before(:each) do
    Devise::OmniAuth.short_circuit_authorizers!
  end

  after(:each) do
   Devise::OmniAuth.unshort_circuit_authorizers!
  end

  def sign_in(provider)
    visit "/users/auth/facebook"
    visit "/users/auth/facebook/callback"
  end
  context "Facebook logon" do
    ACCESS_TOKEN = {
      :access_token => "TEST"
    }

    FACEBOOK_INFO = {
      :id => '12345',
      :link => 'http://facebook.com/user_example',
      :email => 'user@example.com',
      :first_name => 'User',
      :last_name => 'Example',
      :website => 'http://blog.plataformatec.com.br'
    }

    before(:each) do
      Devise::OmniAuth.stub!(:facebook) do |b|
        Rails.logger.info "Stubbing facebook"
        b.post('/oauth/access_token') { [200, {}, ACCESS_TOKEN.to_json] }
        b.get('/me?access_token=TEST') { [200, {}, FACEBOOK_INFO.to_json] }
      end
    end

    after(:each) do
      Devise::OmniAuth.reset_stubs!
    end

    context "First sign-in" do
      it "should create a user" do
        User.should_receive(:create!)
        sign_in("facebook")
      end

      it "should log the user in"
    end

    context "Repeated sign-in" do
      it "shouldn't create a user"
      it "should find the existing user"
      it "should log the user in"
    end
  end
end
