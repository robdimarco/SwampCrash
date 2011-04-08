module QuizzesHelper
  def answer_text_field(qq)
    val = @answer_sheet.nil? ? '' : @answer_sheet.answers_hash[qq.id.to_i] 
    text_field_tag "answer_#{qq.id}", val, :class=>'user_answer'
  end
end
