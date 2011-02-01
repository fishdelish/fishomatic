require 'open-uri'
require 'uri'
require 'fish_files'

class ExternalFishFile < ActiveRecord::Base
  include FishFileMethods

  def name
    uri = URI.parse(self.url)
    uri.path.split("/")[-1]
  end

  def file_path
    self.url
  end
end
