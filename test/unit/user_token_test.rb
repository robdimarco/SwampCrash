require 'test_helper'

class UserTokenTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: user_tokens
#
#  id         :integer         primary key
#  user_id    :integer
#  provider   :string(255)
#  uid        :string(255)
#  created_at :timestamp
#  updated_at :timestamp
#  details    :text
#

