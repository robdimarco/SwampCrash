class MoveAnswersToQuestionColumn < ActiveRecord::Migration
  class Answer < ActiveRecord::Base; end
  def up
    add_column :questions, :answers, :text
    add_column :user_answers, :correct_answer, :string
    update_question_answers
    execute "update user_answers set correct_answer = answers.value from answers where correct_answer_id = answers.id"
    drop_table :answers
  end

  def down
    create_table :answers, :force => true do |t|
      t.references :question, :null=>false
      t.text :value, :null=>false
      t.timestamps
    end
    add_index :answers, :question_id
    add_answers

    remove_column :user_answers, :correct_answer
    remove_column :questions, :answers
  end
  private
  def add_answers
    Question.all.each do |q|
      q.answers.each do |a|
        Answer.create(question: q, value: a)
      end
    end
  rescue
    puts $!
  end
  
  def update_question_answers
    Question.all.each do |q|
      q.answers = Answer.where(question_id: q.id).map(&:value)
      q.save
    end
  rescue
    puts $!
  end
end