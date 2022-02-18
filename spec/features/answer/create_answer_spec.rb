require 'rails_helper'

feature 'Create answer', '
  In order to give an answer for the community
  As an authenticated user
  I want be able to create an answer on the question page
' do

  given(:user) { create(:user) }
  given(:question) { create(:question, { user: user }) }

  scenario 'Authenticated user give answer for question' do
    sign_in(user)
    visit question_path(question)
    create_answer

    expect(page).to have_content 'Body body'
  end

  scenario 'Non-authenticated user give answer for question' do
    create :question, { user: user }
    visit '/questions'
    click_on 'Show'
    click_on 'Send'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end