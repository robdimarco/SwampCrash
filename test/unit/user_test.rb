require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "User can get at their owned quizzes" do
    u = Factory.create :user
    q = Factory.create :quiz, :owner=>u
    u.reload
    assert_equal 1, u.owned_quizzes.count
    assert_equal q, u.owned_quizzes.first
  end
  test "User can get at their answered quizzes" do
    q = Factory.create :quiz
    u = Factory.create :user
    AnswerSheet.create :quiz=>q, :user=>u
    
    u.reload
    assert_equal 1, u.answered_quizzes.count
    assert_equal q, u.answered_quizzes.first
  end
end


# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  reset_password_token :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

