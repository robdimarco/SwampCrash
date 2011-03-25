class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.references :quiz, :null=>false
      t.integer :position, :null=>false
      t.text :value, :null=>false
      t.timestamps
    end
    add_index :questions, [:quiz_id, :position], :unique => true
    add_index :questions, :quiz_id
  end

  def self.down
    remove_index :questions, :quiz_id
    remove_index :questions, :column => [:quiz_id, :position]
    drop_table :questions
  end
end