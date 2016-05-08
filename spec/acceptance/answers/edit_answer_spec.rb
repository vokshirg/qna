require_relative '../acceptance_helper'

feature 'Edit answer' do
  given(:user) {create(:user)}
  given!(:answer) { create :answer }

  scenario 'Non-authenticated user tries edit any answer', js: true do
    visit question_path(answer.question)

    within(".answer") do
      expect(page).to_not have_content  I18n.t('common.edit')
    end
  end

  describe "Authenticated user" do
    scenario 'tries edit non-own answer', js: true do
      sign_in(user)

      visit question_path(answer.question)
      within(".answer") do
        expect(page).to_not have_content  I18n.t('common.edit')
      end

      expect(current_path).to eq question_path(answer.question)
    end

    scenario 'tries edit own answer', js: true do
      sign_in(answer.user)
      visit question_path(answer.question)

      within(".answer") do
        click_on I18n.t('common.edit')
        fill_in 'Body', with: 'repair misprint'
        click_on I18n.t('common.save')
      end

      expect(page).to have_content 'repair misprint'
      expect(page).to_not have_content "Text of answer body"
      expect(current_path).to eq question_path(answer.question)
    end
  end
end
