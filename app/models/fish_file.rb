class FishFile < ActiveRecord::Base
  belongs_to :user
  has_attached_file :fish_file
end
