require 'rails_helper'

feature 'Show all questions, method index' do
  scenario 'any user can see all questions' do
    create_list(:question_sequence, 3)

    visit questions_path

    expect(page).to have_content "Title #1"
    expect(page).to have_content "Title #2"
    expect(page).to have_content "Title #3"
    expect(page).to have_content "Text of question body"
  end
end
