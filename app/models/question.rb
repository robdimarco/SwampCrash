class Question < ActiveRecord::Base
  acts_as_taggable
  has_many :answers
  accepts_nested_attributes_for :answers, :tags
  def answers_str
    answers.collect(&:value).join(",")
  end
  def answers_str=(a_str)
    self.answers.destroy_all
    self.answers = a_str.split(/\s*,\s*/).collect{|a|Answer.find_or_initialize_by_question_id_and_value(:question_id=>self, :value=>a)}
  end
  def self.import_from_file!(file_name, options={})
    require 'csv'
    options = options.merge({col_sep: "\t", headers: true, header_converters: :symbol, skip_blanks: true})
    CSV.foreach(file_name, options) do |row|
      q = Question.create!(value: row[:question], reference_url: row[:url], answers_attributes: row[:answers].split(/\s*,\s*/).collect{|a|{value: a}})
      q.tag_list = row[:tags]
      q.save!
    end
  end
end




# == Schema Information
#
# Table name: questions
#
#  id            :integer         not null, primary key
#  value         :text            not null
#  reference_url :text
#  created_at    :datetime
#  updated_at    :datetime
#

