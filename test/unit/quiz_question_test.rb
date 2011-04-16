require 'test_helper'

class QuizQuestionTest < ActiveSupport::TestCase
  %w(value answers_str).each do |m|
    test "Can delegate question #{m}" do 
      q = Factory.create :quiz_question
      assert_not_nil q.send(:"#{m}")
      assert_equal q.question.send(:"#{m}"), q.send(:"#{m}")
    end
  end  
  {:value=>'foo', :answers_str=>'foo,bar,baz'}.each_pair do |m, v|
    test "Can delegate question #{m}=" do 
      q = Factory.create :quiz_question
      q.send(:"#{m}=", v)
      assert_equal v, q.question.send(:"#{m}")
      assert_equal v, q.send(:"#{m}")
    end
  end
end

# == Schema Information
#
# Table name: quiz_questions
#
#  id          :integer         not null, primary key
#  question_id :integer
#  quiz_id     :integer
#  position    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

