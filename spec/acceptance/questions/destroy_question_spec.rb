require 'rails_helper'

feature 'Destroy question' do
  scenario 'Non-authenticated user tries delete any question' 

  scenario 'Authenticated user tries delete non-own question' 

  scenario 'Authenticated user tries delete own question' 
end
