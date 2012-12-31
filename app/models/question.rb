class Question < ActiveRecord::Base
  acts_as_taggable
  belongs_to :quiz
  before_validation :set_position
  accepts_nested_attributes_for :tags
  attr_accessible :value, :reference_url, :tag_list, :answers_str, :position
  validates :position, uniqueness: {:scope=>:quiz_id}, numericality: true
  validates :quiz, presence: true
  serialize :answers, Array

  after_destroy lambda {
    UserAnswer.joins(:answer_sheet).where(question_id: self.id, answer_sheets:{quiz_id: self.quiz_id}).destroy_all
  }
  
  def answers_str
    self.answers.join(",")
  end
  
  def answers_str=(a_str)
    self.answers = a_str.split(/\s*,\s*/)
  end
  
  def valid_answer(v)
    self.answers.detect{ |ans| ans.downcase.strip == v.to_s.downcase.strip }
  end
  
  private
  def set_position
    self.position ||= self.quiz.present? ? self.quiz.questions.count : 0
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

