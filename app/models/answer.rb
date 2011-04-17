class Answer < ActiveRecord::Base
  belongs_to :question
  
  def matches?(v)
    self.value.downcase.strip == v.to_s.downcase.strip
  end
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

