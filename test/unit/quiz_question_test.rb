require 'test_helper'

class QuizQuestionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
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

