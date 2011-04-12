class QuizQuestion < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :question
  validates_uniqueness_of :position, :scope=>:question_id
  validates_numericality_of :position
  validates_presence_of :quiz, :question
end

# == Schema Information
#
# Table name: quiz_questions
#
#  id          :integer         not null, primary key
#  question_id :integer
#  quiz_id     :integer
#  position    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

