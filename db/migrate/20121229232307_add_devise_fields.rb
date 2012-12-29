class AddDeviseFields < ActiveRecord::Migration
  def up
    add_column :users, :reset_password_sent_at, :timestamp
  end

  def down
  end
end