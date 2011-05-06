require 'test_helper'

class UserControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  test "Must be signed in to see user edit pages" do
    get :index
    assert_redirected_to new_user_session_path
  end
  test "Logged in user can see edit page" do
    u = Factory.create :user
    sign_in u
    get :index
    assert_response :success
  end
  test "Logged in user can save changes" do
    u = Factory.create :user
    sign_in u
    put :update, :user=>{:full_name=>'New Bogus Name'}
    assert_redirected_to current_user_path
    u.reload
    assert_equal "New Bogus Name", u.full_name
  end
end
