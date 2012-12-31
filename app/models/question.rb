class Question < ActiveRecord::Base
  acts_as_taggable
  has_many :answers, :dependent=>:destroy
  has_many :quiz_questions, :dependent=>:destroy
  accepts_nested_attributes_for :answers, :tags
  attr_accessible :value, :reference_url, :answers_attributes, :answers, :tag_list, :answers_str
  
  def answers_str
    answers.collect(&:value).join(",")
  end
  def answers_str=(a_str)
    self.answers.destroy_all
    self.answers = a_str.split(/\s*,\s*/).map{ |a|
      Answer.find_or_initialize_by_question_id_and_value(:question_id=>self.id, :value=>a)
    }
  end
end





# == Schema Information
#
# Table name: questions
#
#  id            :integer         primary key
#  value         :text            not null
#  reference_url :text
#  created_at    :timestamp
#  updated_at    :timestamp
#

