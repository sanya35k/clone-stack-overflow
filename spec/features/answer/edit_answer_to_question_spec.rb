require 'support/features_helper'

feature 'Edit answer to question', '
  In order to fix answer
  As an authenticated user
  I want be able to edit answer
' do

  scenario 'Authenticated user tries to edit answer', js: true do
    user = create(:user)
    question = create(:question, user_id: user.id)
    answer = create(:answer, question: question, user_id: user.id)

    sign_in(user)
    visit question_path(question)
    within '.answers' do
      click_on 'Edit'
      fill_in 'answer[body]', with: 'New answer'
      click_on 'Save'
      expect(page).to_not have_content answer.body
      expect(page).to have_content('New answer')
      expect(page).to_not have_selector('textarea')
    end
  end

  scenario 'Non-authenticated user tries to edit answer' do
    question = create(:question)
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link('Edit')
    end
  end
end