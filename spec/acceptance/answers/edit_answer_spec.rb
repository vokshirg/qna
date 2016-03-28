require 'rails_helper'

feature 'Edit answer' do
  given(:user) {create(:user)}
  given(:user2) {create(:user)}
  given(:answer) { create :answer, user_id: user.id }

  scenario 'Non-authenticated user tries edit any answer' do
    visit question_path(answer.question)

    within(".answer") do
      click_on I18n.t('common.edit')
    end

    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end

  scenario 'Authenticated user tries edit non-own answer' do
    sign_in(user2)

    visit question_path(answer.question)
    within(".answer") do
      click_on I18n.t('common.edit')
    end


    expect(page).to have_content 'You are not author of this answer'
    expect(current_path).to eq question_path(answer.question)
  end

  scenario 'Authenticated user tries edit own answer' do
    sign_in(user)

    visit question_path(answer.question)
    within(".answer") do
      click_on I18n.t('common.edit')
    end
    fill_in 'Body', with: 'repair misprint'
    click_on I18n.t('common.save')


    expect(page).to have_content 'repair misprint'
    expect(current_path).to eq question_path(answer.question)
  end
end
