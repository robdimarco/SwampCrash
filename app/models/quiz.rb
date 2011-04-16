class Quiz < ActiveRecord::Base
  scope :active, where(:status => "active")
  belongs_to :owner, :class_name=>"User", :foreign_key=>"owner_id"
  has_many :quiz_questions, :order=>"position"
  has_many :questions, :through=>:quiz_questions
  has_many :answer_sheets
  before_validation(:on=>:create) {self.status ||= 'pending'}
  validates_inclusion_of :status, :in => %w( pending active complete )

  #
  # Current score in a hash with keys as question ids.  For each question id key, the value is a hash
  # with keys of the answer IDs and values of the count of people with that answer
  #
  def scorecard_hash(force_refresh=false)
    if @card.nil? or force_refresh
      # For each question...
      @card = questions.inject({}){|hsh,q| hsh[q.id] = q.answers.inject({}){|hsh2, ans|hsh2[ans.id] = 0;hsh2};hsh}
      self.answer_sheets.each do |as|
        as.answers.each do |ua|
          @card[ua.question.id][ua.correct_answer_id] += 1 unless ua.correct_answer.nil?
        end
      end
    end
    @card
  end
    
  def to_param
    "#{id}-#{name.parameterize}"
  end
end



# == Schema Information
#
# Table name: quizzes
#
#  id          :integer         not null, primary key
#  name        :string(255)     not null
#  description :text
#  owner_id    :integer         not null
#  created_at  :datetime
#  updated_at  :datetime
#  status      :string(255)     default("pending")
#

