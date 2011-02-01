require 'fish_files'

class FishFile < ActiveRecord::Base
  belongs_to :user
  has_attached_file :fish_file
  include FishFileMethods

  def file_path
    self.fish_file.path
  end

  def name
    File.basename(self.fish_file.path)
  end
end
