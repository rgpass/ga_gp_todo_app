FactoryGirl.define do
  factory :task do
    title       "Walk the dog"
    completed   false
    user
  end

  sequence :name do |n|
    "Name-#{n}"
  end

  sequence :email do |n|
    "email-#{n}@email.com"
  end

  factory :user do
    name
    email
    password              "foobar"
    password_confirmation "foobar"
  end
end
