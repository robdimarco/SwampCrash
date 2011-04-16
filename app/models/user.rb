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
    #self.name = omniauth['user_info']['name'] if name.blank?
    #self.nickname = omniauth['user_info']['nickname'] if nickname.blank?
    
    user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :details=>omniauth)
  end

  def password_required?
    (user_tokens.empty? || !password.blank?) && super
  end

  def email_required?
    (user_tokens.empty? || !email.blank?) && super
  end
  def to_s
    unless user_tokens.empty?
      user_info_token = user_tokens.detect{|t|t.details.include?("user_info")}
      return user_info_token.details["user_info"]["name"] unless user_info_token.nil?
    end
    email
  end
end



# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)
#  encrypted_password   :string(128)
#  reset_password_token :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  password_salt        :string(255)
#  confirmation_token   :string(255)
#  confirmed_at         :datetime
#  confirmation_sent_at :datetime
#  authentication_token :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

