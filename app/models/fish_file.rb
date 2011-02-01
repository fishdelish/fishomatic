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

  def build_file(params, uid)
    str = <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:fish="http://fishdelish.cs.man.ac.uk/rdf/vocab/resource/" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#">
  <fish:observation>
    <rdfs:Label>#{params[:label]}</rdfs:Label>
    <fish:species>#{params[:species]}</fish:species>
    <fish:lat_lng>#{params[:lat_long]}</fish:lat_lng>
    <fish:remarks>#{params[:remarks]}</fish:remarks>
    <fish:attachment>#{params[:attachment]}</fish:attachment>
    <fish:locality>#{params[:locality]}</fish:locality>
    <fish:temperature>#{params[:temperature]}</fish:temperature>
  </fish:observation>
</rdf:RDF>
EOF
    File.open("./tmp/#{uid}", "w") {|f| f.write(str)}
    self.fish_file = File.open("./tmp/#{uid}")
  end
end
