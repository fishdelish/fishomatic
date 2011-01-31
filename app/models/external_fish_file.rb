require 'open-uri'
require 'uri'

class ExternalFishFile < ActiveRecord::Base
  def name
    uri = URI.parse(self.url)
    uri.path.split("/")[-1]
  end

  def data
    file = open(self.url)
    file.read
  end
end
