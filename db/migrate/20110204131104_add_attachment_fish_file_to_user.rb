class AddAttachmentFishFileToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :fish_file_file_name, :string
    add_column :users, :fish_file_content_type, :string
    add_column :users, :fish_file_file_size, :integer
    add_column :users, :fish_file_updated_at, :datetime
    drop_table :fish_files
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration.new
  end
end
