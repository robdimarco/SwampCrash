require 'test_helper'

class QuizzesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @user = Factory.create(:user)
    @quiz = Factory.create :quiz, :owner=>@user
  end

  test "no active quizzes so no current" do
    get :index
    assert_equal 0, Quiz.active.count
    assert_select "#CurrentCrashBox ul li", false
  end

  test "active quizzes show as current" do
    Factory.create :quiz, :status=>'active'
    get :index
    assert_equal 1, Quiz.active.count
    assert_select "#CurrentCrashBox ul li"
  end
  
  test "no logged in user results in no owned quizzes" do
    get :index
    assert_select "#OwnerCrashBox", false
  end

  test "logged in user results with no owned quizzes" do
    sign_in Factory.create(:user)
    get :index
    assert_select "#OwnerCrashBox", false
  end

  test "logged in user results with owned quizzes" do
    sign_in @user
    get :index
    assert_select "#OwnerCrashBox ul li"
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get :new
    assert_response :success
  end

  test "should create quiz" do
    sign_in @user
    assert_difference('Quiz.count') do
      post :create, :quiz => {:name=>'Bogus'}
    end

    assert_redirected_to edit_quiz_path(assigns(:quiz))
  end

  test "should show quiz" do
    get :show, :id => @quiz.to_param
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get :edit, :id => @quiz.to_param
    assert_response :success
  end

  test "should update quiz" do
    sign_in @user
    put :update, :id => @quiz.to_param, :quiz => @quiz.attributes
    assert_redirected_to quiz_path(assigns(:quiz))
  end

  test "should destroy quiz" do
    sign_in @user
    assert_difference('Quiz.count', -1) do
      delete :destroy, :id => @quiz.to_param
    end

    assert_redirected_to quizzes_path
  end
  
  {edit: :get, update: :put, destroy: :delete, :new=>:get}.each_pair do |k,v|
    test "Need to be logged in to perform #{k}" do
      assert_no_difference 'Quiz.count' do
        send(v, k, {:id=>@quiz.to_param})
        assert_redirected_to new_user_session_path
      end
    end
  end
end
