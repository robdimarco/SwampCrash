class AnswerSheet < ActiveRecord::Base
  belongs_to :user
  belongs_to :quiz
  has_many :answers, :class_name=>"UserAnswer"
  validates_presence_of :user, :quiz
  before_validation(:on=>:create) {self.status ||= 'pending'}
  before_validation :grade!
  validates_inclusion_of :status, :in => %w( pending graded )

  def grade!
    answers.each do |a|
      next unless a.current_answer.nil?
      a.current_answer = q.answers.where(:value=>a.value).first
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

