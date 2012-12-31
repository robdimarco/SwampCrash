class AnswerSheet < ActiveRecord::Base
  belongs_to :user
  belongs_to :quiz
  has_many :answers, :class_name=>"UserAnswer"
  validates_presence_of :user, :quiz
  before_validation(:on=>:create) {self.status ||= 'pending'}
  validates_inclusion_of :status, :in => %w( pending graded )
  attr_accessible :quiz, :user
  
  def current_score(for_question_ids=nil)
    for_question_ids = score_by_question_id_hash.keys if for_question_ids.nil?
    for_question_ids.collect{|q|score_by_question_id_hash[q]}.sum
  end
  def score_by_question_id_hash
    if @score_by_question_id_hash.nil?
      scorecard = quiz.scorecard
      @score_by_question_id_hash = self.answers.inject({}) do |hsh, ans|
        hsh[ans.question.id] = ans.incorrect? ? scorecard.incorrect_points(ans.question.id) : scorecard.correct_points(ans.question.id, ans.correct_answer_id)
        hsh
      end
    end
    @score_by_question_id_hash
  end

  def grade!
    self.save!
    self.answers.each do |a|
      a.correct_answer = a.question.answers.detect{|ans|ans.matches?(a.value)} if a.correct_answer.nil?
      a.save!
    end
  end  

  def answer_for_question(q)
    q = q.id if q.is_a?(Question)
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
#  id         :integer         primary key
#  quiz_id    :integer
#  user_id    :integer
#  created_at :timestamp
#  updated_at :timestamp
#  status     :string(255)     default("pending"), not null
#

