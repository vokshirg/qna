require 'rails_helper'

feature 'Answer for question' do
  given(:user) {create(:user)}
  given(:question) { create :question, user: user }

  scenario 'Non-authenticated user tries answer the question' do
    visit question_path(question)
    within(".question") do
      expect(page).to_not have_content  I18n.t('common.answer')
    end
  end

  scenario 'Authenticated user tries to answer the question' do
    sign_in(user)
    visit question_path(question)
    click_on I18n.t('common.answer')

    fill_in 'Body', with: 'My new answers body'
    click_on I18n.t("helpers.submit.create", model: I18n.t('activerecord.models.answer'))

    expect(page).to have_content 'My new answers body'
    expect(current_path).to eq question_path(question)
  end
end
