class Quiz < ActiveRecord::Base
  scope :active, where(:status => "active")
  belongs_to :owner, :class_name=>"User", :foreign_key=>"owner_id"
  has_many :quiz_questions, :order=>"position"
  has_many :questions, :through=>:quiz_questions
  has_many :answer_sheets
  before_validation(:on=>:create) {self.status ||= 'pending'}
  validates_inclusion_of :status, :in => %w( pending active complete )
    
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

