require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  test "can create scorecard" do
    quiz = Factory.create :quiz
    qq   = Factory.create :quiz_question, :quiz=>quiz
    answer = Factory.create :answer, :question=>qq.question
    answer2 = Factory.create :answer, :question=>qq.question
    as = Factory.create :answer_sheet, :quiz=>quiz
    as.answers_hash={answer.question.id=>answer.value} # set a correct answer
    as.grade!

    as2 = Factory.create :answer_sheet, :quiz=>quiz
    as2.answers_hash={answer.question.id=>'WRONG ANSWER'} # set up a correct answer
    as2.grade!
    
    sc = quiz.scorecard
    assert_not_nil sc
    q_res = sc.scoring_details_for_question qq.question_id
    assert_not_nil q_res
    
    assert_equal 6, sc.incorrect_points(qq.question.id)
    assert_equal 1, sc.max_points_for_question(qq.question.id)
    assert_equal 1, sc.correct_points(qq.question.id, answer.id)
    
    assert_equal 1, q_res.correct_answers.length
    assert_equal answer, q_res.correct_answers.first[:correct_answer]
    
    assert_equal 1, q_res.correct_answers.first[:user_answers].length
    assert_equal as.answers.first, q_res.correct_answers.first[:user_answers].first
    assert_equal 1, q_res.missed_answers.length
    assert_equal answer2, q_res.missed_answers.first
    assert_equal 1, q_res.incorrect_user_answers.length
    assert_equal as2.answers.first, q_res.incorrect_user_answers.first
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
#  status      :string(255)     default("pending")
#

