require 'test_helper'

class QuizzesHelperTest < ActionView::TestCase
  test "foo" do
    qq = FactoryGirl.create :question
    assert_not_nil answer_text_field(qq)
  end
end
