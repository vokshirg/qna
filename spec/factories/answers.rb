FactoryGirl.define do
  factory :answer do
    question_id 1
    body "MyText"
  end
  factory :invalid_answer do
    body nil
  end
end
