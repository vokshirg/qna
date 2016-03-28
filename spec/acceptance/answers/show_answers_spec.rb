require 'rails_helper'

feature 'Show all answers for questions, method index' do
  given(:answer) { create :answer }

  scenario 'any user can see all answers for questions' do
    visit question_path(answer.question)

    expect(page).to have_content "Text of question body"
    expect(page).to have_content "Text of answer body"
  end
end
