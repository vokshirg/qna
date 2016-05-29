require 'acceptance_helper'

feature 'User sign in', %q{
  In order to be able to ask question
  As an user
  I want to be able to sign in
} do
  given(:user) {create(:confirmed_user)}

  scenario 'Registred user try to sign in' do
    sign_in(user)

    expect(page).to have_content I18n.t('devise.sessions.signed_in')
    expect(current_path).to eq root_path
  end

  scenario 'Non-registred user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'new@test.ru'
    fill_in 'Password', with: '12341234'
    click_button I18n.t('devise.sessions.new.sign_in')

    expect(page).to have_content I18n.t('devise.failure.not_found_in_database', authentication_keys: 'email')
    expect(current_path).to eq new_user_session_path
  end
end
