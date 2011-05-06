class User < ActiveRecord::Base
  has_many :user_tokens
  has_many :answer_sheets
  has_many :answered_quizzes, :through=>:answer_sheets, :source=>:quiz
  has_many :owned_quizzes, :class_name=>'Quiz', :foreign_key=>'owner_id'
  
  # Include default devise modules. Others available are:
  # :encryptable, :lockable, :timeoutable and :omniauthable, :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  #validates_presence_of :full_name

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session[:omniauth]
        user.user_tokens.build(:provider => data['provider'], :uid => data['uid'])
      end
    end
  end
  
  def apply_omniauth(omniauth)
    Rails.logger.debug "Applying omniauth: #{omniauth.inspect}"
    #add some info about the user
    self.full_name = omniauth['user_info']['name'] if self.full_name.blank?
    self.full_name = omniauth['user_info']['nickname'] if self.full_name.blank?
    
    user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :details=>omniauth)
  end

  def password_required?
    (user_tokens.empty? || !password.blank?) && super
  end

  def email_required?
    (user_tokens.empty? || !email.blank?) && super
  end
  def to_s
    full_name
  end
end





# == Schema Information
#
# Table name: users
#
#  id                      :integer         primary key
#  email                   :string(255)
#  encrypted_password      :string(128)
#  reset_password_token    :string(255)
#  remember_created_at     :timestamp
#  sign_in_count           :integer         default(0)
#  current_sign_in_at      :timestamp
#  last_sign_in_at         :timestamp
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  password_salt           :string(255)
#  confirmation_token      :string(255)
#  confirmed_at            :timestamp
#  confirmation_sent_at    :timestamp
#  authentication_token    :string(255)
#  created_at              :timestamp
#  updated_at              :timestamp
#  image_url               :text
#  full_name               :string(255)
#  notify_me_on_completion :boolean         default(TRUE)
#  notify_me_on_new        :boolean         default(TRUE)
#

