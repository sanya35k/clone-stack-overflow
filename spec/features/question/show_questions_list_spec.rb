require 'rails_helper'

feature 'Show questions list', '
  In order to see questions list
  As an non-authenticated user
  I want be able to see questions list
' do

  scenario 'Non-authenticated user see questions list' do
    user = create(:user)
    create :question, { user: user }
    visit '/questions'

    expect(page).to have_content 'TitleQuestion'
    expect(page).to have_content 'Ask question'
  end

  scenario 'Non-authenticated user open page of empty questions list' do
    visit '/questions'

    expect(page).to_not have_content 'TitleQuestion'
    expect(page).to have_content 'Ask question'
  end
end