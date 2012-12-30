# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
u = User.create! :email=>'rob.dimarco@416software.com', :password=>'changeme', :password_confirmation=>'changeme'

require 'csv'
CSV.foreach(File.join(File.dirname(__FILE__), "base_questions.tsv"), {col_sep: "\t", headers: true, header_converters: :symbol, skip_blanks: true}) do |row|
  q = Question.create!(value: row[:question], reference_url: row[:url], answers_attributes: row[:answers].split(/\s*,\s*/).collect{|a|{value: a}})
  q.tag_list = row[:tags]
  q.save!
end

q = Quiz.create! :owner=>u, :name=>'Initial One'

Question.all.each_with_index{|qq, i| q.quiz_questions << QuizQuestion.new(:question=>qq, :position=>i)}
