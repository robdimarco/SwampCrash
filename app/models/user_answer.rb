class UserAnswer < ActiveRecord::Base
  belongs_to :answer_sheet
  belongs_to :question
  validates_presence_of :answer_sheet, :question, :value
end
