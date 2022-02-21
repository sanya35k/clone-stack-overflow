require 'rails_helper'

feature 'Show answers list', '
  In order to see answers list
  As an non-authenticated user
  I want be able to see answers list
' do

  given(:user) { create(:user) }
  given(:question) { create(:question, { user: user }) }
  given!(:answer) { create(:answer, { question: question, user: user }) }

  scenario 'Non-authenticated user see answers list' do
    visit '/questions'
    expect(page).to have_content 'Ask question'
    click_on 'Show'
    expect(page).to_not have_content 'Delete'
    expect(page).to have_content 'BodyQuestion'
    expect(page).to have_content 'All questions'
  end

  scenario 'Non-authenticated user open page of empty answers list' do
    DatabaseCleaner.clean

    visit '/questions'

    expect(page).to have_content 'Ask question'
  end
end