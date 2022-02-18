require 'rails_helper'

feature 'Delete answer', '
  In order to change answers list
  As an authenticated user and creator answer
  I want be able to delete my answer
' do

  given(:user) { create(:user) }
  given(:question) { create(:question, { user: user }) }

  scenario 'Authenticated user and answer creator delete his answer', js: true do
    sign_in(user)
    visit question_path(question)
    create_answer
    save_and_open_page
    click_on 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to_not have_content 'Test answer'
  end

  scenario 'Non-authenticated user and answer creator trying to delete answer' do
    question = create :question, { user: user }
    create :answer, { question: question, user: user }
    visit '/questions'
    click_on 'Show'

    expect(page).to_not have_content 'Delete'
    expect(page).to have_content 'TitleQuestion'
    expect(page).to have_content 'BodyQuestion'
  end
end