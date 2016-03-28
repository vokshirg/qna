FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    email
    password '123123123'
    password_confirmation '123123123'
    confirmed_at Time.now
  end

  factory :confirmed_user, :parent => :user do
    after(:create) { |user| user.confirm! }
  end
end
