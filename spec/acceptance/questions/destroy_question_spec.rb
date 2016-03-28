require 'rails_helper'

feature 'Destroy question' do
  given(:user) {create(:user)}
  given(:user2) {create(:user)}
  given(:question) { create :question, user: user }

  scenario 'Non-authenticated user tries delete any question' do
    question
    visit questions_path
    click_on I18n.t('common.delete')
    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end

  scenario 'Authenticated user tries delete non-own question' do
    sign_in(user2)
    question

    visit questions_path
    click_on I18n.t('common.delete')

    expect(page).to have_content 'You are not author of this question'
    expect(current_path).to eq questions_path
  end

  scenario 'Authenticated user tries delete own question' do
    sign_in(user)
    question

    visit questions_path
    click_on I18n.t('common.delete')

    expect(current_path).to eq questions_path
  end
end
