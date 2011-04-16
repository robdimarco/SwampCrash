class AddCorrectAnswerLinkToUserAnswer < ActiveRecord::Migration
  def self.up
    add_column :user_answers, :correct_answer_id, :integer, :null=>true
  end

  def self.down
    remove_column :user_answers, :correct_answer_id
  end
end