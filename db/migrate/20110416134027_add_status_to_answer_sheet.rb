class AddStatusToAnswerSheet < ActiveRecord::Migration
  def self.up
    add_column :answer_sheets, :status, :string, :null=>false, :default=>"pending"
  end

  def self.down
    remove_column :answer_sheets, :status
  end
end