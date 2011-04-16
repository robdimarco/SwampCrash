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
    self.save!
    self.answers.each do |a|
      a.correct_answer = a.question.answers.where(:value=>a.value).first unless a.correct_answer.nil?
      Rails.logger.debug "Saving #{a.inspect}"
      a.save!
    end
  end  

  def answer_for_question(q)
    q = q.id if q.is_a?(Question)
    q = q.question.id if q.is_a?(QuizQuestion)
    self.answers.detect{|a|a.question_id.to_s==q.to_s}
  end
  def answers_hash(args=nil)
    if args.nil?
      answers.inject({}){|hsh, a| hsh[a.question_id] = a.value;hsh}
    else
      args.each_pair do |k,v|
        a = answer_for_question(k)
        if a.nil?
          Rails.logger.debug "Creating new user answer"
          a = UserAnswer.new(:answer_sheet=>self, :question=>Question.find(k))
          self.answers << a
        else
          Rails.logger.debug "Updating answer #{a.inspect} to value #{v}"
        end
        a.value = v
      end
      args
    end
  end
  alias :answers_hash= :answers_hash
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

