require 'rails_helper'
feature 'User Sign Out' do
  given(:user) {create(:confirmed_user)}
  scenario 'Non-authenticated user tries sign out' do
    page.driver.submit :delete, destroy_user_session_path, {}

    expect(page).to have_content I18n.t('devise.sessions.already_signed_out')
    expect(current_path).to eq root_path
  end

  scenario 'Authenticated user tries sign out' do
    sign_in(user)
    click_on 'Выйти'

    expect(page).to have_content I18n.t('devise.sessions.signed_out')
    expect(current_path).to eq root_path
  end
end
