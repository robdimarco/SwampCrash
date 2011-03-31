class CreateUserAnswers < ActiveRecord::Migration
  def self.up
    create_table :user_answers do |t|
      t.integer :answer_sheet_id
      t.integer :question_id
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :user_answers
  end
end
