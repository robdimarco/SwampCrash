require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "can create question from hash" do
    assert_difference "Question.count" do 
      assert_difference "Answer.count", 4 do
        Question.create! :value=>'Test', :answers_attributes=>%w(Foo Bar Baz Bat).collect{|k|{value: k}}
      end
    end
  end
  test "can save answers from hash" do 
    q = Factory.create :question
    assert_difference 'Answer.count', 3 do
      q.answers_str="foo,bar,baz"
      q.save!
    end
  end
  test "can update answers from hash" do 
    q = Factory.create :question
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
end




# == Schema Information
#
# Table name: questions
#
#  id            :integer         not null, primary key
#  value         :text            not null
#  reference_url :text
#  created_at    :datetime
#  updated_at    :datetime
#

