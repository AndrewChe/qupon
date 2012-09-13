require 'factory_girl'

FactoryGirl.define do

  factory :user do
    name "John"
    last_name  "Doe"
    nick_name "JD"
    email "jd@test.test"
    password "pass"
  end

  factory :post do
    title "test post"
    body "test body"
  end

  factory :comment do
    body "perfect!"
  end
end
