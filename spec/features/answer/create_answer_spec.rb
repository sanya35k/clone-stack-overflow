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

    expect(page).to have_content 'All questions'
    expect(page).to have_content 'TitleQuestion'
    expect(page).to have_content 'BodyQuestion'
  end

  scenario 'Non-authenticated user give answer for question' do
    visit question_path(question)
    expect(page).to_not have_content 'Send'
  end
end