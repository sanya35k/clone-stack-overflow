require 'rails_helper'

feature 'Show questions list', '
  In order to see questions list
  As an non-authenticated user
  I want be able to see questions list
' do

  given(:user) { create(:user) }
  given!(:question) { create(:question, { user: user }) }

  scenario 'Authenticated user and question creator show questions list' do
    sign_in(user)
    visit '/questions'
    expect(page).to have_content 'Question'
    expect(page).to have_content 'Delete'

    click_on 'Show'

    expect(page).to have_content 'Question'
    expect(page).to have_content 'TitleQuestion'
    expect(page).to have_content 'BodyQuestion'
  end


  scenario 'Non-authenticated user see questions list' do
    user = create(:user)
    create :question, { user: user }
    visit '/questions'

    expect(page).to have_content 'TitleQuestion'
    expect(page).to have_content 'Question'
    expect(page).to have_content 'Ask question'
  end

  scenario 'Non-authenticated user open page of empty questions list' do
    DatabaseCleaner.clean
    visit '/questions'

    expect(page).to_not have_content 'TitleQuestion'
    expect(page).to_not have_content 'Show'
    expect(page).to have_content 'Ask question'
  end
end