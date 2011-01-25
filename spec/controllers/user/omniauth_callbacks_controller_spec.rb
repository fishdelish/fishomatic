require 'spec_helper'

describe User::OmniauthCallbacksController do
  let(:user) {mock_model(User)}

  before do
    controller.stub!(:redirect_to)
    controller.stub!(:sign_in_and_redirect)
  end

  def sign_in(provider)
    controller.send(provider.to_sym)
  end

  it "should redirect omniauth failures to /" do
    controller.send(:after_omniauth_failure_path_for, :user).should == root_url
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

    before do
      controller.stub!(:get_oauth_data).and_return(FACEBOOK_INFO.stringify_keys)
    end

    context "Successful sign-in" do
      before do
        user.stub!(:persisted?).and_return(true)
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

      it "should inform the user of the success" do
        sign_in("facebook")
        flash[:notice].should == "Successfully signed in with Facebook"
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

      it "should redirect the user to root" do
        controller.should_receive(:redirect_to).with(root_url)
        sign_in("facebook")
      end

      it "should provide an error message"

    end
  end
end
