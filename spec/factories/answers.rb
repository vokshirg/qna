FactoryGirl.define do
  factory :answer do
    user
    question
    body "Text of answer body"
  end
  factory :invalid_answer, class: 'Answer' do
    user
    question
    body nil
  end
end
