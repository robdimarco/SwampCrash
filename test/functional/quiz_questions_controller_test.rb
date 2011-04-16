require 'test_helper'

class QuizQuestionsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @user = Factory.create(:user)
    @quiz = Factory.create :quiz, :owner=>@user
    @quiz_question = Factory.create :quiz_question, :quiz=>@quiz
    sign_in @user
  end

  test "should get new" do
    get :new,:id=>@quiz.id
    assert_response :success
  end

  test "should create quiz_question" do
    assert_difference('QuizQuestion.count') do
      post :create, :question => {:value=>'Test', :reference_url=>'ba'}, :id=>@quiz.id
    end

    assert_redirected_to edit_quiz_path(assigns(:quiz))
  end

  test "should show quiz_question" do
    get :show, :id => @quiz_question.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @quiz_question.to_param
    assert_response :success
  end

  test "should update quiz_question" do
    put :update, :id => @quiz_question.to_param, :quiz_question => @quiz_question.attributes
    assert_redirected_to quiz_question_path(assigns(:quiz_question))
  end

  test "should destroy quiz_question" do
    assert_difference('QuizQuestion.count', -1) do
      delete :destroy, :id => @quiz_question.to_param
    end

    assert_redirected_to edit_quiz_path(@quiz)
  end
end
