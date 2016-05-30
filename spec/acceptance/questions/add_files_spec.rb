require 'acceptance_helper'

feature 'Add files to question', %q{
  In order to illustrate  my question
  As an question's author
  I'd like  to be able to attach files
} do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User add any files when create question', js: true do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test text'
    attach_file 'File', "#{Rails.root}/spec/acceptance_helper.rb"
    page.find(".add_fields").click
    within all('.nested-fields').last do
      attach_file 'File' , "#{Rails.root}/spec/rails_helper.rb"
    end
    click_on I18n.t("helpers.submit.create", model: I18n.t('activerecord.models.question'))

    expect(page).to have_link 'acceptance_helper.rb', href: '/uploads/attachment/file/1/acceptance_helper.rb'
    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
  end
end