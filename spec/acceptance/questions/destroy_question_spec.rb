require_relative '../acceptance_helper'

feature 'Destroy question' do
  given(:user) {create(:user)}
  given(:question) { create :question }

  scenario 'Non-authenticated user tries delete any question' do
    question
    visit questions_path

    within(".question") do
      expect(page).to_not have_content  I18n.t('common.delete')
    end
  end

  scenario 'Authenticated user tries delete non-own question' do
    sign_in(user)
    question

    visit questions_path
    within(".question") do
      expect(page).to_not have_content  I18n.t('common.delete')
    end

    expect(current_path).to eq questions_path
  end

  scenario 'Authenticated user tries delete own question' do
    sign_in(question.user)

    visit questions_path
    click_on I18n.t('common.delete')

    expect(page).to_not have_content question.title
    expect(current_path).to eq questions_path
  end
end
