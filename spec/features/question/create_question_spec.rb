require 'support/features_helper'

feature 'Create question', '
  In order to get an answer from the community
  As an authenticated user
  I want to be able to create questions
' do

  given(:user) { create(:user) }

  scenario 'Authenticated user creates the question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask a question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    click_on 'Ask!'

    expect(page).to have_content 'Question was successfully created.'
  end

  scenario 'Non-authenticated user tries to create the question' do
    visit questions_path
    click_on 'Ask a question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end
