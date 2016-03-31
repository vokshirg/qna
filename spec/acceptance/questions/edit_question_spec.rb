require 'rails_helper'

feature 'Edit question' do
  given(:user) {create(:user)}
  given(:question) { create :question }

  scenario 'Non-authenticated user tries edit any question' do
    visit question_path(question)
    within(".question") do
      expect(page).to_not have_content  I18n.t('common.edit')
    end
  end

  scenario 'Authenticated user tries edit non-own question' do
    sign_in(user)

    visit question_path(question)
    within(".question") do
      expect(page).to_not have_content  I18n.t('common.edit')
    end
    expect(current_path).to eq question_path(question)
  end

  scenario 'Authenticated user tries edit own question' do
    sign_in(question.user)

    visit question_path(question)
    click_on I18n.t('common.edit')

    fill_in 'Title', with: 'New Test question'
    fill_in 'Body', with: 'New Test text'
    click_on I18n.t('common.save')

    expect(page).to have_content 'New Test question'
    expect(page).to have_content 'New Test text'
    expect(page).to_not have_content "Text of question body"
    expect(page).to_not have_content "MyString"
    expect(current_path).to eq question_path(question)
  end

end
