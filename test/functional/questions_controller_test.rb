require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @user = FactoryGirl.create(:user)
    @quiz = FactoryGirl.create :quiz, :owner=>@user
    @question = FactoryGirl.create :question, :quiz=>@quiz
    sign_in @user
  end

  test "should get new" do
    get :new,:id=>@quiz.id
    assert_response :success
  end

  test "should create question" do
    assert_difference('Question.count') do
      post :create, :question => {:value=>'Test', :reference_url=>'ba', :answers_str=>'a,b,c', :tag_list=>'boo,hoo'}, :id=>@quiz.id
    end

    assert_redirected_to edit_quiz_path(assigns(:quiz))
    q = Question.last
    assert_equal 'Test', q.value
    assert_equal 'ba', q.reference_url
    assert_equal 'a,b,c', q.answers_str
    assert_equal ["boo", "hoo"], q.tag_list.sort
  end

  test "should get edit" do
    get :edit, :id => @question.to_param
    assert_response :success
  end

  test "should update question" do
    put :update, :id => @question.to_param, question: { value: 'foo' }
    assert_redirected_to edit_quiz_path(assigns(:quiz))
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete :destroy, :id => @question.to_param
    end

    assert_redirected_to edit_quiz_path(@quiz)
  end
end
