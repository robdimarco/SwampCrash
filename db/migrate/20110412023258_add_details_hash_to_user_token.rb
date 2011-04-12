class AddDetailsHashToUserToken < ActiveRecord::Migration
  def self.up
    add_column :user_tokens, :details, :text
  end

  def self.down
    remove_column :user_tokens, :details
  end
end