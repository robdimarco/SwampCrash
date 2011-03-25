class Quiz < ActiveRecord::Base
  belongs_to :owner, :class_name=>"User", :foreign_key=>"owner_id"
  has_many :questions, :order=>"position"
end
