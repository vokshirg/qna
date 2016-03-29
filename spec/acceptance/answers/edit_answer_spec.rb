require 'rails_helper'

feature 'Edit answer' do
  given(:user) {create(:user)}
  given(:answer) { create :answer }

  scenario 'Non-authenticated user tries edit any answer' do
    visit question_path(answer.question)

    within(".answer") do
      expect(page).to_not have_content  I18n.t('common.edit')
    end
  end

  scenario 'Authenticated user tries edit non-own answer' do
    sign_in(user)

    visit question_path(answer.question)
    within(".answer") do
      expect(page).to_not have_content  I18n.t('common.edit')
    end

    expect(current_path).to eq question_path(answer.question)
  end

  scenario 'Authenticated user tries edit own answer' do
    sign_in(answer.user)
    visit question_path(answer.question)

    within(".answer") do
      click_on I18n.t('common.edit')
    end
    fill_in 'Body', with: 'repair misprint'
    click_on I18n.t('common.save')

    expect(page).to have_content 'repair misprint'
    expect(page).to_not have_content "Text of answer body"
    expect(current_path).to eq question_path(answer.question)
  end
end
