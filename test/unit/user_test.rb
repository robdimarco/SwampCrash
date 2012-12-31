require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "User can get at their owned quizzes" do
    u = FactoryGirl.create :user
    q = FactoryGirl.create :quiz, :owner=>u
    u.reload
    assert_equal 1, u.owned_quizzes.count
    assert_equal q, u.owned_quizzes.first
  end
  test "User can get at their answered quizzes" do
    q = FactoryGirl.create :quiz
    u = FactoryGirl.create :user
    AnswerSheet.create :quiz=>q, :user=>u
    
    u.reload
    assert_equal 1, u.answered_quizzes.count
    assert_equal q, u.answered_quizzes.first
  end
  test "Can find users who want new notifications" do
    assert_difference ["User.count","User.notify_on_new.count"] do
      u = FactoryGirl.create :user, :notify_me_on_new=>true
      assert u.valid?, "user has errors #{u.errors.to_xml}"
    end
  end
  test "Users who do not want new notifications are not chosen" do
    assert_difference "User.count" do
      assert_no_difference "User.notify_on_new.count" do
        u = FactoryGirl.create :user, :notify_me_on_new=>false
      end
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string(255)
#  encrypted_password      :string(128)
#  reset_password_token    :string(255)
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0)
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  password_salt           :string(255)
#  confirmation_token      :string(255)
#  confirmed_at            :datetime
#  confirmation_sent_at    :datetime
#  authentication_token    :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#  image_url               :text
#  full_name               :string(255)
#  notify_me_on_completion :boolean          default(TRUE)
#  notify_me_on_new        :boolean          default(TRUE)
#  reset_password_sent_at  :datetime
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

