class CreateFishFiles < ActiveRecord::Migration
  def self.up
    create_table :fish_files do |t|
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :fish_files
  end
end
