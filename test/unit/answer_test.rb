require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
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

