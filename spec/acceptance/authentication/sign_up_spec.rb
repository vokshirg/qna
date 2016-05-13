require 'acceptance_helper'

feature 'User Sign Up' do
  given(:user) {create(:confirmed_user)}

  scenario 'Non-registered user tries sign up' do
    visit new_user_registration_path

    fill_in 'Email', with: 'new_email@test.com'
    fill_in 'Password', with: '123456789'
    fill_in 'Password confirmation', with: '123456789'
    click_on 'Регистрация'

    expect(page).to have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
    expect(current_path).to eq root_path
  end

  scenario 'Registered user tries sign up' do
    visit new_user_registration_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: '123456789'
    fill_in 'Password confirmation', with: '123456789'
    click_on 'Регистрация'

    expect(page).to have_content 'Email уже существует'
    expect(current_path).to eq '/users'
  end
end
