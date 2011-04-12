require 'test_helper'

class UserAnswerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
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

