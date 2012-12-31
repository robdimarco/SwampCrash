require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "can create question from hash" do
    assert_difference "Question.count" do 
      assert_difference "Answer.count", 4 do
        q = Question.new :value=>'Test', :answers_attributes=>%w(Foo Bar Baz Bat).collect{|k|{value: k}}
        q.quiz = FactoryGirl.create(:quiz)
        q.save!
      end
    end
  end
  test "can save answers from hash" do 
    q = FactoryGirl.create :question
    assert_difference 'Answer.count', 3 do
      q.answers_str="foo,bar,baz"
      q.save!
    end
  end
  test "can update answers from hash" do 
    q = FactoryGirl.create :question
    assert_difference 'Answer.count', 3 do
      q.answers_str="foo,bar,baz"
      q.save!
    end
    assert_no_difference 'Answer.count' do
      q.answers_str="blah,bags,buff"
      q.save!
    end
    q.reload
    assert_equal "blah,bags,buff".split(",").sort, q.answers.collect(&:value).sort
  end
  test "User answers are deleted when question is deleted" do
    q = Question.new :value=>'Test', :answers_attributes=>%w(Foo Bar Baz Bat).collect{|k|{value: k}}
    q.quiz = FactoryGirl.create(:quiz)
    q.save!
    as = FactoryGirl.create :answer_sheet, :quiz => q.quiz
    assert_difference "UserAnswer.count" do
      as.answers_hash= {q.id=>"Foo"}
      as.grade!
    end
    assert_difference ["Question.count", "UserAnswer.count"], -1 do
      assert_difference ["Answer.count"], -4 do
        q.destroy
      end
    end
  end
end





# == Schema Information
#
# Table name: questions
#
#  id            :integer         primary key
#  value         :text            not null
#  reference_url :text
#  created_at    :timestamp
#  updated_at    :timestamp
#

