require 'support/features_helper'

feature 'Create answer', '
  In order to give an answer for the community
  As an authenticated user
  I want be able to create an answer on the question page
' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user give answer for question', js: true do
    sign_in(user)

    visit question_path(question)
    fill_in 'answer[body]', with: 'My answer'
    click_on 'Submit'

    expect(current_path).to eq question_path(question)
    within 'div.answers', visible: false do
      expect(page).to have_content 'My answer'
    end
  end

  scenario 'Non-authenticated user tries to give answer for question' do
    visit question_path(question)
    expect(page).to_not have_content 'Your answer: '
    expect(page).to have_content 'Login in order to post answers!'
  end

  scenario 'Authenticated user tries to give answer with empty field', js: true do
    sign_in(user)

    visit question_path(question)
    click_on 'Submit'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content "Body can't be blank!"
  end
end
