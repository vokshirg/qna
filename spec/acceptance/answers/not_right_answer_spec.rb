require 'acceptance_helper'

feature 'Uncheck right answer' do
  given(:user) {create(:user)}
  given(:question) { create :question, user: user }
  given(:another_question) { create :question }
  given!(:answer) { create :answer, question: question, right_answer: true }


  scenario 'Author of question tries uncheck right answer', js: true do
    sign_in(question.user)
    visit question_path(question)

    page.first('.not_right_answer_link').click

    expect(current_path).to eq question_path(question)
    expect(page).to_not have_selector('.right_answer')
  end

  scenario "User can't uncheck right answer of other's users questions" do
    sign_in(user)
    visit question_path(another_question)

    expect(page).to_not have_selector('.not_right_answer_link')
  end
end
