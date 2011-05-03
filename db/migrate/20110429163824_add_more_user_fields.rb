class AddMoreUserFields < ActiveRecord::Migration
  def self.up
    add_column :users, :image_url, :text
    add_column :users, :full_name, :string
    add_column :users, :notify_me_on_completion, :boolean, :default=>true
    add_column :users, :notify_me_on_new, :boolean, :default=>true
  end

  def self.down
    remove_column :users, :full_name
    remove_column :users, :image_url
    remove_column :users, :notify_me_on_completion
    remove_column :users, :notify_me_on_new
  end
end