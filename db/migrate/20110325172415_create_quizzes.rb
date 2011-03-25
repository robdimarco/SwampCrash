class CreateQuizzes < ActiveRecord::Migration
  def self.up
    create_table :quizzes do |t|
      t.string :name, :null=>false
      t.text :description
      t.integer :owner_id, :null=>false
      t.timestamps
    end
    add_index :quizzes, :name, :unique => true
  end

  def self.down
    remove_index :quizzes, :column => :name
    drop_table :quizzes
  end
end