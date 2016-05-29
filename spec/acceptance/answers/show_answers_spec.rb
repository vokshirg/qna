require 'acceptance_helper'

feature 'Show all answers for questions, method index' do
  given(:question) { create :question_with_answers }

  scenario 'any user can see all answers for questions' do
    visit question_path(question)

    expect(page).to have_content "Text of answer body #9"
    expect(page).to have_content "Text of answer body #8"
    expect(page).to have_content "Text of answer body #7"
    expect(page).to have_content "Text of question body"
  end
end
