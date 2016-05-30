require 'acceptance_helper'

feature 'Add files to answer', %q{
  In order to illustrate  my answer
  As an answer's author
  I'd like  to be able to attach files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User add file when create answer', js: true do
    fill_in 'Your answer', with: 'My Answer'
    attach_file 'File', "#{Rails.root}/spec/acceptance_helper.rb"
    click_on I18n.t("helpers.submit.create", model: I18n.t('activerecord.models.answer'))

    within '.answers' do
      expect(page).to have_link 'acceptance_helper.rb', href: '/uploads/attachment/file/1/acceptance_helper.rb'
    end

  end
end
