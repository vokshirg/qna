require_relative '../acceptance_helper'

feature 'User Answer', %q{
  In order to echange my knowledge
  As an authenticated user
  I want to be able to create answers
} do

  given(:user) { create :user }
  given(:question ) { create :question  }
  scenario 'Authenticated user create answer', js: true do
    sign_in user
    visit question_path(question)

    fill_in 'Your answer', with: 'My Answer'
    click_on I18n.t("helpers.submit.create", model: I18n.t('activerecord.models.answer'))

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'My Answer'
    end
  end

  scenario 'User tries create  invalid question', js: true do
    sign_in user
    visit question_path(question)

    click_on I18n.t("helpers.submit.create", model: I18n.t('activerecord.models.answer'))

    expect(current_path).to eq question_path(question)

    within '#new_answer' do
      expect(page).to have_content 'Body не может быть пустым'
    end
  end

  scenario 'Non-authenticated user create answer', js: true do
    visit question_path(question)
    expect(page).to_not have_content 'Your answer'
  end
end
