class QuizQuestion < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :question
  validates_uniqueness_of :position, :scope=>:question_id
  validates_numericality_of :position
  validates_presence_of :quiz, :question
end
