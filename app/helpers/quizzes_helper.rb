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
end
