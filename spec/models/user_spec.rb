require 'spec_helper'

describe User do
  it {should validate_presence_of :email}
  it {should validate_presence_of :password}
  it {should have_many :fish_files}

  context "Finding a facebook user" do
    before(:each) do
      User.delete_all
    end

    context "User doesn't exist" do
      it "should create a user" do
        User.should_receive(:create!).with(hash_including(:email => "test@test.host", :password => an_instance_of(String)))
        User.find_by_facebook("test@test.host")
      end

    end
    
    context "User does exist" do
      before(:each) do
        User.stub_chain(:where, :first).and_return(@user = mock_model(User))
      end

      it "should find the user" do
        User.find_by_facebook("test@test.host").should == @user
      end
    end
  end
end
