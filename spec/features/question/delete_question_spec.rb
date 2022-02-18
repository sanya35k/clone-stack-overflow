require 'rails_helper'

feature 'Delete question', '
  In order to change questions list
  As an authenticated user and creator question
  I want be able to delete my question
' do

  given(:user) { create(:user) }

  scenario 'Authenticated user and question creator delete his question', js: true do
    sign_in(user)
    create_question
    visit '/questions'
    click_on 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to_not have_content 'Test question'
    expect(current_path).to eq '/questions'
  end

  scenario 'Non-authenticated user and question creator trying to delete question' do
    create :question, { user: user }
    visit '/questions'

    expect(page).to_not have_content 'Delete'
    expect(page).to have_content 'TitleQuestion'
    expect(current_path).to eq '/questions'
  end
end