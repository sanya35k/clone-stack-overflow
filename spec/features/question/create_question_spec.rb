require 'rails_helper'

feature 'Create question', '
  In order to get an answer from the community
  As an authenticated user
  I want be able to ask questions
' do

  given(:user) { create(:user) }

  scenario 'Authenticated user asks question' do
    sign_in(user)
    create_question
    visit '/questions'

    expect(page).to have_content 'Test question'
  end

  scenario 'Non-authenticated user asks question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end
