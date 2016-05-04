require 'rails_helper'

feature 'Destroy answer' do
  given(:user) {create(:user)}
  given(:answer) { create :answer }

  scenario 'Non-authenticated user tries delete any answer' do
    visit question_path(answer.question)

    within(".answer") do
      expect(page).to_not have_content  I18n.t('common.delete')
    end
  end

  scenario 'Authenticated user tries delete non-own answer' do
    sign_in(user)

    visit question_path(answer.question)
    within(".answer") do
      expect(page).to_not have_content  I18n.t('common.delete')
    end
    expect(current_path).to eq question_path(answer.question)
  end

  scenario 'Authenticated user tries delete own answer', js: true do
    sign_in(answer.user)

    visit question_path(answer.question)
    click_on I18n.t('common.delete')
    page.driver.browser.switch_to.alert.accept

    expect(page).to_not have_content answer.body
    expect(current_path).to eq question_path(answer.question)
  end
end
