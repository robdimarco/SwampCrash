class AnswerSheet < ActiveRecord::Base
  belongs_to :user
  belongs_to :quiz
  has_many :answers, :class_name=>"UserAnswer"
  validates_presence_of :user, :quiz
  before_validation(:on=>:create) {self.status ||= 'pending'}
  validates_inclusion_of :status, :in => %w( pending graded )

  def current_score
    scorecard = quiz.scorecard_hash
    answers.inject(0) do |sum, ans|
      sum += if ans.incorrect?
        scorecard[ans.question.id].values.max + 5
      else
        scorecard[ans.question.id][ans.correct_answer_id]
      end
    end
  end

  def grade!
    save!
    answers.each do |a|
      next unless a.correct_answer.nil?
      a.correct_answer = a.question.answers.where(:value=>a.value).first
      a.save!
    end
  end  

  def answer_for_question(q)
    q = q.id if q.is_a?(Question)
    q = q.question.id if q.is_a?(QuizQuestion)
    answers.where(:question_id=>q).first
  end
  def answers_hash(args=nil)
    if args.nil?
      answers.inject({}){|hsh, a| hsh[a.question_id] = a.value;hsh}
    else
      args.each_pair do |k,v|
        a = answers.where(:question_id=>k).first
        if a.nil?
          a = UserAnswer.new(:answer_sheet=>self, :question=>Question.find(k))
          self.answers << a
        end
        a.value = v
      end
      args
    end
  end
  alias :answers_hash= :answers_hash
  def value=(v)
    correct_answer = nil unless v == self.value
    super
  end
end

# == Schema Information
#
# Table name: answer_sheets
#
#  id         :integer         not null, primary key
#  quiz_id    :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

