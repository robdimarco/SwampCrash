class UserToken < ActiveRecord::Base
  belongs_to :user
  serialize :details
end
# == Schema Information
#
# Table name: user_tokens
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  uid        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

