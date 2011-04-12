Factory.sequence :email do |n|
  "person#{n}@example.com" 
end  

Factory.sequence :quiz_name do |n|
  "Test Quiz #{n}"
end

Factory.define :user do |u|
  u.email {Factory.next(:email)}
  u.password 'changeme'
  u.password_confirmation 'changeme'
end

Factory.define :quiz do |q|
  q.name {Factory.next(:quiz_name)}
  q.association :owner, :factory=>:user
  q.status 'pending'
end

Factory.define :question do |q|
  q.value 'Foo'
  q.reference_url nil
end

Factory.define :answer do |a|
  a.value 'Bar'
  a.association :question
end

Factory.define :answer_sheet do |a|
  a.association :user, :factory=>:user
  a.association :quiz, :factory=>:quiz
end

Factory.define :quiz_question do |qq|
  qq.association :quiz
  qq.association :question
  qq.position {|qqq| qqq.quiz.questions.count + 1}
end