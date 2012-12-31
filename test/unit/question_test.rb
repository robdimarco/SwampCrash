require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "can create question from hash" do
    assert_difference "Question.count" do 
      q = Question.new :value=>'Test', answers_str: "Foo, Bar, Baz, Bat"
      q.quiz = FactoryGirl.create(:quiz)
      q.save!
    end
  end
  test "can save answers from hash" do 
    q = FactoryGirl.create :question
    q.answers_str="foo,bar,baz"
    assert_equal(%w[foo bar baz].sort, q.answers.sort)
  end
  test "can update answers from hash" do 
    q = FactoryGirl.create :question
    q.answers_str="foo,bar,baz"
    assert_equal(%w[foo bar baz].sort, q.answers.sort)
    q.answers_str="blah,bags,buff"
    q.save!

    q.reload
    assert_equal %w[blah bags buff].sort, q.answers.sort
  end
  test "User answers are deleted when question is deleted" do
    q = Question.new :value=>'Test', answers_str: "Foo, Bar, Baz, Bat"
    q.quiz = FactoryGirl.create(:quiz)
    q.save!
    as = FactoryGirl.create :answer_sheet, :quiz => q.quiz
    assert_difference "UserAnswer.count" do
      as.answers_hash= {q.id=>"Foo"}
      as.grade!
    end
    assert_difference ["Question.count", "UserAnswer.count"], -1 do
      q.destroy
    end
  end
end

# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  value         :text             not null
#  reference_url :text
#  created_at    :datetime
#  updated_at    :datetime
#  position      :integer
#  quiz_id       :integer
#  answers       :text
#

