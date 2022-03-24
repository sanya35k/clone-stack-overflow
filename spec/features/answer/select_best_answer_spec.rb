require 'support/features_helper'

feature 'Set the best answer', '
  In order to set the best answer
  As an authenticated user
  I want be able to select the best answer
' do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user_id: user.id) }
  given!(:answer) { create(:answer, user_id: user.id, question: question) }
  scenario 'Authenticated user tries to select the best answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Select as the best'
    expect(page).to have_css('div.green')
  end

  scenario 'Non-authenticated tries to select the best answer' do
    visit question_path(question)
    expect(page).to_not have_content 'Select as the best'
  end
end
