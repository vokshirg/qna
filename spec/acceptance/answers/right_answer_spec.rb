require 'acceptance_helper'

feature 'Select right answer' do
  given(:user) {create(:user)}
  given(:question) { create :question, user: user }
  given(:another_question) { create :question }
  given!(:answers) { create_list :answer_sequence, 3, question: question }


  scenario 'Author of question tries select right answer', js: true do
    sign_in(question.user)
    visit question_path(question)

    page.first('.right_answer_link').click

    expect(current_path).to eq question_path(question)
    expect(page).to have_selector('.right_answer', count: 1)
    expect(page.body).to match /.right_answer.*.answer.*.answer/
  end

  scenario "User can't select right answer of other's users questions" do
    sign_in(user)
    visit question_path(another_question)

    expect(page).to_not have_selector('.right_answer_link')
  end
end
