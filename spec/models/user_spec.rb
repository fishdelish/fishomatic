require 'spec_helper'

describe User do
  it {should validate_presence_of :email}
  it {should validate_presence_of :password}

  it "should create a user if facebook email doesn't exist" do
    User.delete_all
    User.should_receive(:create!).with(hash_including(:email => "test@test.host", :password => an_instance_of(String)))
    User.find_by_facebook("test@test.host")
  end
end
