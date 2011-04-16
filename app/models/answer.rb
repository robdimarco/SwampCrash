class Answer < ActiveRecord::Base
  belongs_to :question
end


# == Schema Information
#
# Table name: answers
#
#  id          :integer         not null, primary key
#  question_id :integer         not null
#  value       :text            not null
#  created_at  :datetime
#  updated_at  :datetime
#

