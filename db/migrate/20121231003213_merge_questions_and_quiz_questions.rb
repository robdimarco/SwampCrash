class MergeQuestionsAndQuizQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :position, :integer
    add_column :questions, :quiz_id, :integer
    execute "update questions set position = quiz_questions.position, quiz_id = quiz_questions.quiz_id from quiz_questions where question_id = questions.id"
    drop_table :quiz_questions
  end

  def self.down
    create_table :quiz_questions do |t|
      t.integer :question_id
      t.integer :quiz_id
      t.integer :position
    
      t.timestamps
    end
    execute "insert into quiz_questions(question_id, quiz_id, position, created_at, updated_at) select id, quiz_id, position, now(), now() from questions"
    remove_column :questions, :quiz_id
    remove_column :questions, :position
  end
end