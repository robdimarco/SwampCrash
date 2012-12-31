module QuizzesHelper
  def answer_text_field(qq)
    val = @answer_sheet.nil? ? '' : @answer_sheet.answers_hash[qq.id.to_i] 
    text_field_tag "answer_#{qq.id}", val, :class=>'user_answer'
  end
  def owns_quizzes?(user=nil)
    user = current_user if user.nil? and user_signed_in?
    if user.nil?
      false
    else
      user.owned_quizzes.count > 0
    end
  end
  def correct_answer_select(q, correct_answer)
    select_tag "question_#{q.id}_correct_answer", options_for_select(q.answers, correct_answer),
      {:include_blank=>"Incorrect", :class=>"correct_answer"}
  end
  
  def quiz_view_partial(quiz)
    big_reveal_allowed?(quiz) ? "big_reveal" : "answer_form"
  end
  
  def reveal_delay_in_milliseconds
    params.include?(:reveal_delay) ? params[:reveal_delay] : 5000
  end
  def user_list_for_quiz(join_with=", ")
    User.joins(:answer_sheets).where(:answer_sheets=>{:quiz_id=>@quiz.id}).collect( &:to_s).join(join_with)
  end
end
