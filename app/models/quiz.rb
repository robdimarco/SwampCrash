require 'scorecard'
class Quiz < ActiveRecord::Base
  VALID_STATUS = %w( pending active complete )
  scope :active, where(:status => "active")
  scope :completed, where(:status => "complete").order("updated_at").reverse_order
  belongs_to :owner, :class_name=>"User", :foreign_key=>"owner_id"
  has_many :quiz_questions, :order=>"position"
  has_many :questions, :through=>:quiz_questions, :order=>"position"
  has_many :answer_sheets
  before_validation(:on=>:create) {self.status ||= 'pending'}
  validates_inclusion_of :status, :in => VALID_STATUS
  attr_accessible :name, :description

  VALID_STATUS.each do |st|
    define_method :"#{st}?" do
      self.status == st
    end
  end

  #
  # Current score in a hash with keys as question ids.  For each question id key, the value is a hash
  # with keys of the answer IDs and values of the count of people with that answer
  #
  def scorecard(force_refresh=false)
    @card=Scorecard.new(self) if @card.nil? or force_refresh
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

