require 'spec_helper'

describe User::OmniauthCallbacksController do
  let(:user) {mock_model(User)}

  def sign_in(provider)
    controller.send(provider.to_sym)
  end

  context "Facebook logon" do
    FACEBOOK_INFO = {
      :id => '12345',
      :link => 'http://facebook.com/user_example',
      :email => 'user@example.com',
      :first_name => 'User',
      :last_name => 'Example',
      :website => 'http://blog.plataformatec.com.br'
    }

    before(:each) do
      controller.stub!(:get_oauth_data).and_return(FACEBOOK_INFO.stringify_keys)
    end

    context "Successful sign-in" do
      before do
        user.stub!(:persisted?).and_return(true)
        controller.stub!(:sign_in_and_redirect)
        User.stub!(:find_by_facebook).and_return(user)
      end

      it "should find a user" do
        User.should_receive(:find_by_facebook).with(FACEBOOK_INFO[:email])
        sign_in("facebook")
      end

      it "should log the user in" do
        controller.should_receive(:sign_in_and_redirect).with(user, :event => :authentication)
        sign_in("facebook")
      end
    end

    context "Unsuccessful sign-in" do
      before do
        user.stub!(:persisted?).and_return(false)
        User.stub!(:find_by_facebook).and_return(user)
      end

      it "should try to find a user" do
        User.should_receive(:find_by_facebook).with(FACEBOOK_INFO[:email])
        sign_in("facebook")
      end
    end
  end
end
