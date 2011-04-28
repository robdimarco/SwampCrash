class UserAnswer < ActiveRecord::Base
  belongs_to :answer_sheet
  belongs_to :question
  belongs_to :correct_answer, :class_name=>'Answer'
  validates_presence_of :answer_sheet, :question
  validate :validate_answer_integrity
  attr_accessible :value, :answer_sheet, :question
  def correct?
    !incorrect?
  end
  def incorrect?
    correct_answer.nil?
  end
  def value=(v)
    unless v == read_attribute(:value)
      correct_answer = nil 
      write_attribute(:correct_answer_id, nil)
    end
    write_attribute(:value, v)
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

