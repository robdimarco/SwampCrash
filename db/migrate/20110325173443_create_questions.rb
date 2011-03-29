class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.text :value, :null=>false
      t.text :reference_url
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end