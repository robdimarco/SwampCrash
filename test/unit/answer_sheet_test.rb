require 'test_helper'

class AnswerSheetTest < ActiveSupport::TestCase
  test "Can set answers from hash" do
    q = FactoryGirl.create :quiz
    5.times {FactoryGirl.create(:question, :quiz=>q)}
    q.reload
    
    assert_difference 'AnswerSheet.count' do
      assert_difference 'UserAnswer.count', 5 do
        as = AnswerSheet.new(:quiz=>q, :user=>FactoryGirl.create(:user))
        assert_equal 0, as.answers.count
        assert_equal Hash.new, as.answers_hash
        as.answers_hash = q.questions.inject({}){|hsh,qq|hsh[qq.id]='Foobar';hsh}
        assert_equal q.questions.count, as.answers_hash.length
        as.save!
      end
    end
  end
  
  test "Can grade answer sheet" do
    q = FactoryGirl.create :quiz
    qq = FactoryGirl.create :question, :quiz=>q, answers_str: 'Test'

    as = AnswerSheet.new(:quiz=>q, :user=>FactoryGirl.create(:user))
    as.answers_hash(qq.id=>'Bar')
    assert_equal 'Bar', as.answers_hash[qq.id]
    assert_difference ["AnswerSheet.count", "UserAnswer.count"] do
      as.grade!
    end
    assert_nil as.answer_for_question(qq.id).correct_answer
    
    as.answers_hash(qq.id=>'Test')
    as.grade!
    
    assert_equal 'Test', as.answers_hash[qq.id]
    assert_equal 'Test', as.answer_for_question(qq.id).correct_answer
  end
    
end


# == Schema Information
#
# Table name: answer_sheets
#
#  id         :integer         primary key
#  quiz_id    :integer
#  user_id    :integer
#  created_at :timestamp
#  updated_at :timestamp
#  status     :string(255)     default("pending"), not null
#

