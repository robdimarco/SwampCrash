class CreateAnswerSheets < ActiveRecord::Migration
  def self.up
    create_table :answer_sheets do |t|
      t.integer :quiz_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :answer_sheets
  end
end
