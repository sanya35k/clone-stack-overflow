require 'support/features_helper'

feature 'Edit question', '
  In order to fix question
  As an authenticated user
  I want be able to edit question
' do
  scenario 'Authenticated user tries to edit question', js: true do
    user = create(:user)
    question = create(:question, user_id: user.id)

    sign_in(user)
    visit question_path(question)
    within '.question' do
      click_on 'Edit'
      fill_in 'question[body]', with: 'New question'
      click_on 'Save'
      expect(page).to_not have_content question.body
      expect(page).to have_content('New question')
      expect(page).to_not have_selector('textarea')
    end
  end

  scenario 'Non-authenticated user tries to edit question' do
    question = create(:question)
    visit question_path(question)
    within '.question' do
      expect(page).to_not have_link('Edit')
    end
  end
end
