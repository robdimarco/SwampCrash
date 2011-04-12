class UserAnswer < ActiveRecord::Base
  belongs_to :answer_sheet
  belongs_to :question
  validates_presence_of :answer_sheet, :question, :value
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

