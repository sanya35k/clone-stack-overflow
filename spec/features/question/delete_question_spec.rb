require 'rails_helper'

feature 'Delete question', '
  In order to change questions list
  As an authenticated user and creator question
  I want be able to delete my question
' do

  given(:user) { create(:user) }
  given!(:question) { create(:question, { user: user }) }

  scenario 'Authenticated user and question creator delete his question', js: true do
    sign_in(user)
    visit '/questions'
    click_on 'Delete'

    expect(page).to_not have_content 'Test question'
  end

  scenario 'Non-authenticated user trying to delete question' do
    visit '/questions'

    expect(page).to_not have_content 'Delete'
    expect(page).to have_content 'TitleQuestion'
    expect(current_path).to eq '/questions'
  end
end