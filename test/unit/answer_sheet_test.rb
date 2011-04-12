require 'test_helper'

class AnswerSheetTest < ActiveSupport::TestCase
  test "Can set answers from hash" do
    q = Factory.create :quiz
    5.times {Factory.create(:quiz_question, :quiz=>q)}
    q.reload
    
    assert_difference 'AnswerSheet.count' do
      assert_difference 'UserAnswer.count', 5 do
        as = AnswerSheet.new(:quiz=>q, :user=>Factory.create(:user))
        assert_equal 0, as.answers.count
        assert_equal Hash.new, as.answers_hash
        as.answers_hash = q.questions.inject({}){|hsh,qq|hsh[qq.id]='Foobar';hsh}
        assert_equal q.questions.count, as.answers_hash.length
        as.save!
      end
    end
  end
end

# == Schema Information
#
# Table name: answer_sheets
#
#  id         :integer         not null, primary key
#  quiz_id    :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

