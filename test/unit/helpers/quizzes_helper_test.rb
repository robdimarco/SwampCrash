require 'test_helper'

class QuizzesHelperTest < ActionView::TestCase
  test "foo" do
    qq = Factory.create :question
    assert_not_nil answer_text_field(qq)
  end
end
