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
  attr_accessible :email, :password, :password_confirmation, :remember_me, :notify_me_on_completion, :notify_me_on_new, :full_name
  
  scope :notify_on_new, where(:notify_me_on_new =>true).where("email != '' and email is not null")

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
    
    ut = user_tokens.build
    ut.provider = omniauth['provider']
    ut.uid = omniauth['uid']
    ut.details = omniauth
  end

  def password_required?
    (user_tokens.empty? || !password.blank?) && super
  end

  def email_required?
    (user_tokens.empty? || !email.blank?) && super
  end
  def to_s
    if full_name.present?
      full_name
    elsif email.present?
      email.split("@")[0][0..5] + "..."
    else
      "?"
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string(255)
#  encrypted_password      :string(128)
#  reset_password_token    :string(255)
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0)
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  password_salt           :string(255)
#  confirmation_token      :string(255)
#  confirmed_at            :datetime
#  confirmation_sent_at    :datetime
#  authentication_token    :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#  image_url               :text
#  full_name               :string(255)
#  notify_me_on_completion :boolean          default(TRUE)
#  notify_me_on_new        :boolean          default(TRUE)
#  reset_password_sent_at  :datetime
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

