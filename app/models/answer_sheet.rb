class AnswerSheet < ActiveRecord::Base
  belongs_to :user
  belongs_to :quiz
  has_many :answers, :class_name=>"UserAnswer"
  validates_presence_of :user, :quiz
  def answers_hash(args=nil)
    if args.nil?
      answers.inject({}){|hsh, a| hsh[a.question_id] = a.value;hsh}
    else
      args.each_pair do |k,v|
        a = answers.where(:question_id=>q).first
        if a.nil?
          a = UserAnswer.new(:answer_sheet=>self)
          self.answers << a
        end
        a.value = v
      end
    end
  end
  alias :answers_hash= :answers_hash
end
