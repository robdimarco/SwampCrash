class AddStatusToQuiz < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :status, :string, :default=>'pending'
  end

  def self.down
    remove_column :quizzes, :status
  end
end