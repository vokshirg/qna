require 'rails_helper'

feature 'Show all questions, method index' do
  scenario 'any user can see all questions' do
    create_list(:question_sequence, 3)

    visit questions_path

    3.times do |i|
      expect(page).to have_content "Title ##{i+1}"
    end
    expect(page).to have_content "Text of question body"
  end
end
