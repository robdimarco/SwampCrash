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
end