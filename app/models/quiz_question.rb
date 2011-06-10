class QuizQuestion < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :question
  validates_uniqueness_of :position, :scope=>:question_id
  validates_numericality_of :position
  validates_presence_of :quiz, :question
  after_destroy lambda {
    UserAnswer.joins(:answer_sheet).where(question_id: self.question_id, 'answer_sheets.quiz_id' => self.quiz_id).destroy_all
  }
  %w(value value= reference_url reference_url= answers_str answers_str=).each do |m|
    delegate m.to_sym, :to=>:question
  end
  attr_accessible :question, :quiz, :position    
end


# == Schema Information
#
# Table name: quiz_questions
#
#  id          :integer         primary key
#  question_id :integer
#  quiz_id     :integer
#  position    :integer
#  created_at  :timestamp
#  updated_at  :timestamp
#

