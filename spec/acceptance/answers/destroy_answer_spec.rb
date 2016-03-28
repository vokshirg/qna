require 'rails_helper'

feature 'Destroy answer' do
  scenario 'Non-authenticated user tries delete any answer'

  scenario 'Authenticated user tries delete non-own answer'

  scenario 'Authenticated user tries delete own answer' 
end
