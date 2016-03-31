FactoryGirl.define do
  sequence :body do |n|
    "Text of answer body ##{n}"
  end

  factory :answer do
    user
    question
    body "Text of answer body"

    factory :answer_sequence do
      body
    end

  end
  factory :invalid_answer, class: 'Answer' do
    user
    question
    body nil
  end
end
