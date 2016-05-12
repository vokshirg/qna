require_relative '../acceptance_helper'

feature 'Select right answer' do
  given(:user) {create(:user)}
  given(:question) { create :question }
  given(:answer) { create :answer, question: question }

  scenario 'Author tries select right answer' do
    sign_in(question.user)
    visit question_path(question)

    click_link 'Right Answer'

    # текущий путь прежний
    # отмеченный ответ первый
    # правильный ответ не дублируется

  end
  scenario 'Not-author can"t select right answer'
end
