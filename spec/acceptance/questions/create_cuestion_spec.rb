require 'rails_helper'

feature 'Create question', %q{
  In order to get anser from community
  As ans authenticated user
  I want to be able to ask question
} do

  given(:user) {create(:user)}

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Задать вопрос'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test text'
    click_on I18n.t("helpers.submit.create", model: I18n.t('activerecord.models.question'))

    expect(page).to have_content 'Test question'
    expect(page).to have_content 'Test text'
    expect(page).to have_content 'Your question successfully created'
  end

  scenario 'Non-authenticated user tries to create question' do
    visit questions_path
    click_on 'Задать вопрос'

    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end
end
