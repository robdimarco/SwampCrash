class UserAnswer < ActiveRecord::Base
  belongs_to :answer_sheet
  belongs_to :question

  validates_presence_of :answer_sheet, :question
  attr_accessible :value, :answer_sheet, :question, :correct_answer
  def correct?
    !incorrect?
  end
  def incorrect?
    correct_answer.blank?
  end
  def value=(v)
    correct_answer = nil unless v == read_attribute(:value)
    write_attribute(:value, v)
  end
end

# == Schema Information
#
# Table name: user_answers
#
#  id              :integer          not null, primary key
#  answer_sheet_id :integer
#  question_id     :integer
#  value           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  correct_answer  :string(255)
#

