class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.references :question, :null=>false
      t.text :value, :null=>false
      t.timestamps
    end
    add_index :answers, :question_id
  end

  def self.down
    remove_index :answers, :question_id
    drop_table :answers
  end
end