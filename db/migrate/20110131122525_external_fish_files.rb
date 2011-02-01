class ExternalFishFiles < ActiveRecord::Migration
  def self.up
    create_table :external_fish_files do |t|
      t.string :url
      t.timestamps
    end
  end

  def self.down
  end
end
