require 'rails_helper'

feature 'Edit question' do
  given(:user) {create(:user)}
  given(:user2) {create(:user)}
  given(:question) { create :question, user: user }

  scenario 'Non-authenticated user tries edit any question' do
    visit question_path(question)
    click_on I18n.t('common.edit')

    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end

  scenario 'Authenticated user tries edit non-own question' do
    sign_in(user2)

    visit question_path(question)
    click_on I18n.t('common.edit')

    expect(page).to have_content 'You are not author of this question'
    expect(current_path).to eq questions_path
  end

  scenario 'Authenticated user tries edit own question' do
    sign_in(user)

    visit question_path(question)
    click_on I18n.t('common.edit')

    fill_in 'Title', with: 'New Test question'
    fill_in 'Body', with: 'New Test text'
    click_on I18n.t('common.save')

    expect(page).to have_content 'Question was successfully updated'
    expect(current_path).to eq question_path(question)
  end

end
