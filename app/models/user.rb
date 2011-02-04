require 'fish_files'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :omniauthable, :validatable, :registerable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :fish_file, :username, :email, :password, :password_confirmation, :remember_me
  attr_readonly :username
  validate :username, :presence => true, :unique => true

  has_attached_file :fish_file
  include FishFileMethods
  def file_path
    self.fish_file.path
  end

  def self.find_by_facebook(email, signed_in_resource=nil)
    if user = User.where(:email => email).first
      user
    else # Create an user with a stub password. 
      User.create!(:email => email, :password => Devise.friendly_token[0,20]) 
    end
  end

  def self.find_by_twitter(email, signed_in_resource=nil)
    if user = User.where(:email => email).first
      user
    else
      User.create!(:email => email, :password => Devise.friendly_token[0, 20])
    end
  end
end
