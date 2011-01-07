require 'spec_helper'

describe User::OmniauthCallbacksController do
  before(:each) do
    Devise::OmniAuth.short_circuit_authorizers!
  end

  after(:each) do
   Devise::OmniAuth.unshort_circuit_authorizers!
  end

  context "Facebook logon" do
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

    before(:each) do
      Devise::OmniAuth.stub!(:facebook) do |b|
        b.post('/oauth/access_token') { [200, {}, ACCESS_TOKEN.to_json] }
        b.get('/me?access_token=plataformatec') { [200, {}, FACEBOOK_INFO.to_json] }
      end
    end

    after(:each) do
      Devise::OmniAuth.reset_stubs!
    end

    context "First sign-in" do
      it "should create a user" do
        User.should_receive(:create!)
        visit "/users/auth/facebook"
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
