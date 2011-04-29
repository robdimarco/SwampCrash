class AddMoreUserFields < ActiveRecord::Migration
  def self.up
    add_column :users, :image_url, :text
    add_column :users, :full_name, :string
  end

  def self.down
    remove_column :users, :full_name
    remove_column :users, :image_url
  end
end