require 'rails_helper'

feature 'Show all questions, method index' do
  scenario 'any user can see all questions' do
    create(:question)

    visit questions_path

    expect(page).to have_content "Text of question body"
  end
end
