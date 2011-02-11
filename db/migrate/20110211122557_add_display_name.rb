class AddDisplayName < ActiveRecord::Migration
  def self.up
    add_column :users, :display_name, :string
    User.all.each do |u|
      u.display_name = u.username
      u.save!
    end
  end

  def self.down
    remove_column :users, :display_name
  end
end
