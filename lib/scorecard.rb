class Scorecard
  PENALTY_POINTS = 5
  def initialize(quiz)
    @quiz = quiz
    question_user_answers = @quiz.questions.inject({}){|hsh,q|hsh[q.id]=[];hsh}
    @quiz.answer_sheets.each do |as|
      as.answers.each do |ua|
        question_user_answers[ua.question_id] << ua if question_user_answers.include?(ua.question_id)
      end
    end
    @scoring_details_by_question = @quiz.questions.inject({}){|hsh, q| hsh[q.id] = ScoreForQuestion.new(@quiz, q, question_user_answers[q.id]);hsh}
  end
  def scoring_details_for_question(question_id)
    @scoring_details_by_question[question_id]
  end
  def incorrect_points(question_id)
    max_points_for_question(question_id) + PENALTY_POINTS
  end
  def max_points_for_question(question_id)
    correct_answers = scoring_details_for_question(question_id).correct_answers
    correct_answers.empty? ? 0 : correct_answers.collect{|hsh| hsh[:user_answers].count}.max
  end
  def correct_points(question_id, answer_id)
    correct_ans_hash = scoring_details_for_question(question_id).correct_answers.detect{|ca|ca[:correct_answer].id == answer_id}
    correct_ans_hash.nil? ? 0 : correct_ans_hash[:user_answers].count
  end
  class ScoreForQuestion
    attr_accessor :correct_answers, :missed_answers, :incorrect_user_answers
    def initialize(quiz, question, user_answers)
      @incorrect_user_answers, @missed_answers = [], question.answers.to_a
      correct_answers_hash = {}
      
      user_answers.each do |ua|
        if ua.incorrect?
          @incorrect_user_answers << ua
        else
          if @missed_answers.include?(ua.correct_answer)
            @missed_answers.delete(ua.correct_answer)
            correct_answers_hash[ua.correct_answer] = []
          end
          correct_answers_hash[ua.correct_answer] << ua
        end
      end
      @correct_answers = correct_answers_hash.keys.map{|ca|{:correct_answer=>ca, :user_answers=>correct_answers_hash[ca]}}.sort{|a,b|a[:user_answers].length <=> b[:user_answers].count}
    end
  end
end