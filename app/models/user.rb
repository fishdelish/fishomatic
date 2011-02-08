require 'fish_files'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :validatable, :registerable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :fish_file, :username, :email, :password, :password_confirmation, :remember_me
  attr_readonly :username
  validate :username, :presence => true, :unique => true

  has_many :authentications

  has_attached_file :fish_file
  include FishFileMethods
  def file_path
    self.fish_file.path
  end
end
