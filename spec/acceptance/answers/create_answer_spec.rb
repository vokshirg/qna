require 'rails_helper'

feature 'User Answer', %q{
  In order to echange my knowledge
  As an authenticated user
  I want to be able to create answers
} do

  given(:user) { create :user }
  given(:question ) { create :question  }
  scenario 'Authenticated user create answer', js: true do
    sign_in user
    visit question_path(question)

    fill_in 'Your answer', with: 'My Answer'
    click_on I18n.t("helpers.submit.create", model: I18n.t('activerecord.models.answer'))

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'My Answer'
    end
  end
end
