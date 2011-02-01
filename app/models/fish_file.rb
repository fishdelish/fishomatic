class FishFile < ActiveRecord::Base
  belongs_to :user
  has_attached_file :fish_file

  def data
    @file = open(self.fish_file.path)
    @content = @file.read
    @content.gsub!(/<fish:species>(.*)<\/fish:species>/) do |match|
      species_uri = "http://fishdelish.cs.man.ac.uk/rdf/species/" + $1.gsub(/ /, "/")
      species_tag = "<fish:speciesURI>http://fishdelish.cs.man.ac.uk/species/species.php?uri=#{@species_uri}</fish:speciesURI>"
      match + species_tag
    end
  end

  def name
    File.basename(self.fish_file.path)
  end
end
