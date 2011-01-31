class AddAttachmentFishFileToFishFile < ActiveRecord::Migration
  def self.up
    add_column :fish_files, :fish_file_file_name, :string
    add_column :fish_files, :fish_file_content_type, :string
    add_column :fish_files, :fish_file_file_size, :integer
    add_column :fish_files, :fish_file_updated_at, :datetime
  end

  def self.down
    remove_column :fish_files, :fish_file_file_name
    remove_column :fish_files, :fish_file_content_type
    remove_column :fish_files, :fish_file_file_size
    remove_column :fish_files, :fish_file_updated_at
  end
end
