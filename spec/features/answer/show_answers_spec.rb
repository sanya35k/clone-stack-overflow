require 'rails_helper'

feature 'Show answers list', '
  In order to see answers list
  As an non-authenticated user
  I want be able to see answers list
' do

  scenario 'Non-authenticated user see answers list' do
    user = create(:user)
    question = create(:question, { user: user })
    answer = create(:answer, { question: question, user: user })
    visit '/questions'

    click_on 'Show'
    expect(page).to have_content 'TitleQuestion'
    expect(page).to have_content 'All questions'
  end

  scenario 'Non-authenticated user open page of empty answers list' do
    visit '/questions'

    expect(page).to_not have_content 'TitleQuestion'
    expect(page).to have_content 'Ask question'
  end
end