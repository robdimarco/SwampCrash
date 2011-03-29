require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: quizzes
#
#  id          :integer         not null, primary key
#  name        :string(255)     not null
#  description :text
#  owner_id    :integer         not null
#  created_at  :datetime
#  updated_at  :datetime
#

