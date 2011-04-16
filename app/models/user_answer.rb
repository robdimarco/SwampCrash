class UserAnswer < ActiveRecord::Base
  belongs_to :answer_sheet
  belongs_to :question
  belongs_to :correct_answer, :class_name=>'Answer'
  validates_presence_of :answer_sheet, :question
  validate :validate_answer_integrity
  def correct?
    !incorrect?
  end
  def incorrect?
    correct_answer.nil?
  end
  private
  def validate_answer_integrity
    correct_answer.nil? or correct_answer.question = self.question
  end
end

# == Schema Information
#
# Table name: user_answers
#
#  id              :integer         not null, primary key
#  answer_sheet_id :integer
#  question_id     :integer
#  value           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

