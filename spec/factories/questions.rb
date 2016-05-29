FactoryGirl.define do
  sequence :title do |n|
    "Title ##{n}"
  end

  factory :question do
    user
    title "MyString"
    body "Text of question body"

    factory :question_with_answers, class: 'Question' do
      after(:create) do |question|
        create_list(:answer_sequence, 3, question: question)
      end
    end

    factory :question_with_right_answers, class: 'Question' do
      after(:create) do |question|
        create_list(:answer_sequence, 3, question: question, right_answer: true)
      end
    end

    factory :question_sequence, class: 'Question' do
      title
    end
  end
  factory :invalid_question, class: 'Question' do
    user
    title nil
    body nil
  end

end
