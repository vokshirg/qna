require 'rails_helper'

feature 'Create question', %q{
  In order to get anser from community
  As ans authenticated user
  I want to be able to ask question
} do
  scenario 'Authenticated user creates question' do
    User.create!(email: 'email@test.ru', password: '12341234')

    visit new_user_session_path
    fill_in 'Email', with: 'email@test.ru'
    fill_in 'Password', with: '12341234'
    click_on 'Sign in'

    visit questions_path
    click_on 'Задать вопрос'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test text'
    click_on 'Create Question'

    expect(page).to have_content 'Your question successfully created'
  end

  scenario 'Non-authenticated user tries to create question' do

    visit questions_path
    click_on 'Задать вопрос'

    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end
end
