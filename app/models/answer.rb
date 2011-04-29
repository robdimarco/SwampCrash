class Answer < ActiveRecord::Base
  belongs_to :question
  attr_accessible :value, :question_id
  def matches?(v)
    self.value.downcase.strip == v.to_s.downcase.strip
  end
end



# == Schema Information
#
# Table name: answers
#
#  id          :integer         primary key
#  question_id :integer         not null
#  value       :text            not null
#  created_at  :timestamp
#  updated_at  :timestamp
#

