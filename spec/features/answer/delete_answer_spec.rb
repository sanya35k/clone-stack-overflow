require 'rails_helper'

feature 'Delete answer', '
  In order to change answers list
  As an authenticated user and creator answer
  I want be able to delete my answer
' do

  given(:user) { create(:user) }
  given(:question) { create(:question, { user: user }) }
  given!(:answer) { create(:answer, { question: question, user: user }) }

  scenario 'Authenticated user and answer creator delete his answer', js: true do
    sign_in(user)

    visit question_path(question)

    expect(page).to have_content 'All questions'
    expect(page).to have_content 'Delete'
    expect(page).to have_content 'Enter your answer'
  end

  scenario 'Non-authenticated user trying to delete answer', :js => true do
    question = create :question, { user: user }
    create :answer, { question: question, user: user }
    visit question_path(question)

    expect(page).to_not have_content 'Delete'
    expect(page).to have_content 'TitleQuestion'
    expect(page).to have_content 'BodyQuestion'
  end
end