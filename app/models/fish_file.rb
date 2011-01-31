class FishFile < ActiveRecord::Base
  belongs_to :user
  has_attached_file :fish_file

  def data
    @file = open(self.fish_file.path)
    @file.read
  end

  def name
    File.basename(self.fish_file.path)
  end
end
