require 'support/features_helper'

feature 'Set opinion for the answer', '
  In order to set my opinion
  As an authenticated user and not an author
  I want to be able to set opinion for the answer
' do
  given(:author) { create(:user) }
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user_id: user.id) }
  given!(:answer) { create(:answer, user_id: author.id, question: question) }

  scenario 'Authenticated user and not an author set his opinion for the answer', js: true do
    sign_in author

    visit question_path(question)

    # first(".vote-button").click
    # expect(page).to have_content('1')
    # all(".vote-button").last.click
    # expect(page).to have_content('-1')
    # all(".vote-button").last.click
    # expect(page).to have_content('0')
  end
  scenario 'Authenticated user and an author set his opinion for the answer', js: true do
    sign_in author

    visit question_path(question)

    # accept_alert("You can't set your opinion for your answer!") do
    #   first('.vote-button').click
    # end
  end
end