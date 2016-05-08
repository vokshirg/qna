require_relative '../acceptance_helper'

feature 'Show question' do
  given(:question) { create :question }

  scenario 'any user can see question and answers' do
    visit question_path(question)

    expect(page).to have_content "MyString"
    expect(page).to have_content "Text of question body"
  end
end
