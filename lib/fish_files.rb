module FishFileMethods
  def data
    @file = open(file_path)
    @content = @file.read
    @content.gsub!(/<fish:species>(.*)<\/fish:species>/) do |match|
      species_uri = "http://fishdelish.cs.man.ac.uk/rdf/species/" + $1.gsub(/ /, "/")
      species_tag = "<fish:speciesURI>http://fishdelish.cs.man.ac.uk/species/species.php?uri=#{species_uri}</fish:speciesURI>"
      match + species_tag
    end
  end
end
