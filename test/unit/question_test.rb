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

