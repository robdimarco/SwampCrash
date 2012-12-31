FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com" 
  end  

  sequence :quiz_name do |n|
    "Test Quiz #{n}"
  end

  factory :user do |u|
    u.email {generate(:email)}
    u.full_name 'Change Me'
    u.password 'changeme'
    u.password_confirmation 'changeme'
    u.notify_me_on_completion true
    u.notify_me_on_new true
  end

  factory :quiz do |q|
    q.name {generate(:quiz_name)}
    q.association :owner, :factory=>:user
    q.status 'pending'
  end

  factory :question do |q|
    q.value 'Foo'
    q.reference_url nil
    q.association :quiz
  end

  factory :answer_sheet do |a|
    a.association :user, :factory=>:user
    a.association :quiz, :factory=>:quiz
  end
end