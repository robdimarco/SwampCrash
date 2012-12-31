class RemoveCorrectAnswerIdFromUserAnswers < ActiveRecord::Migration
  def up
    remove_column :user_answers, :correct_answer_id
  end

  def down
    add_column :user_answers, :correct_answer_id, :integer
  end
end
