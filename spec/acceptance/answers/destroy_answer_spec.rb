require 'rails_helper'

feature 'Destroy answer' do
  given(:user) {create(:user)}
  given(:user2) {create(:user)}
  given(:answer) { create :answer, user_id: user.id }

  scenario 'Non-authenticated user tries delete any answer' do
    visit question_path(answer.question)

    click_on I18n.t('common.delete')
    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end

  scenario 'Authenticated user tries delete non-own answer' do
    sign_in(user2)

    visit question_path(answer.question)
    click_on I18n.t('common.delete')

    expect(page).to have_content 'You are not author of this answer'
    expect(current_path).to eq question_path(answer.question)
  end

  scenario 'Authenticated user tries delete own answer' do
    sign_in(user)

    visit question_path(answer.question)
    click_on I18n.t('common.delete')

    expect(page).to_not have_content answer.body
    expect(current_path).to eq question_path(answer.question)
  end
end
