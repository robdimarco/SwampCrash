require 'scorecard'
class Quiz < ActiveRecord::Base
  belongs_to :owner, :class_name=>"User", :foreign_key=>"owner_id"
  has_many :questions, :order=>"position", dependent: :destroy
  has_many :answer_sheets, dependent: :destroy
  attr_accessible :name, :description

  
  module StateMachine
    def self.included(base)
      base.send :include, AASM
      base.class_eval do
        #
        # State transitions
        #
        aasm_column :status
        aasm_initial_state :pending
        %w( pending active complete ).each{|st| 
          aasm_state st.to_sym
        }
  
        aasm_event :publish, :after=>:after_publish do
          transitions :to=>:active, :from=>:pending
        end
        aasm_event :complete, :after=>:after_complete do
          transitions :to=>:complete, :from=>:active
        end
        def after_publish
          User.notify_on_new.each do |u|
            QuizStatusChangeMailer.crash_published(u,self).deliver
          end
        end
        def after_complete
          self.answer_sheets.collect(&:user).select{|u|!u.nil? and !u.email.blank? and u.notify_me_on_completion?}.each do |u|
            QuizStatusChangeMailer.crash_completed(u,self).deliver
          end
        end
      end
    end
  end
  include Quiz::StateMachine
  
  scope :active, where(:status => "active")
  scope :completed, where(:status => "complete").order("updated_at").reverse_order
  scope :released_publicly, where(:status => ["active", "complete"]).order("updated_at").reverse_order
  
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
#  id          :integer         primary key
#  name        :string(255)     not null
#  description :text
#  owner_id    :integer         not null
#  created_at  :timestamp
#  updated_at  :timestamp
#  status      :string(255)     default("pending")
#

