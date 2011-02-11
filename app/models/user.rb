require 'fish_files'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :validatable, :registerable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :fish_file, :username, :email, :password, :password_confirmation, :remember_me, :display_name
  attr_readonly :username
  validate :username, :presence => true, :unique => true

  has_many :authentications

  before_save :check_display_name

  has_attached_file :fish_file
  include FishFileMethods
  def file_path
    self.fish_file.path
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if auth = session["devise.omniauth"]
        user.authentications.build(:provider => auth["provider"], :uid => auth["uid"])
        session["devise.omniauth"] = nil
      end
    end
  end

  def check_display_name
    self.display_name = self.username if self.display_name.empty?
  end
end
