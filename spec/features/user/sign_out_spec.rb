require 'rails_helper'

feature 'User sign out', '
  In order be able to end the session
  As an authenticated user
  I want be able to sign out
' do

  given(:user) { create(:user) }

  scenario 'Authenticated user logs out' do
    sign_in(user)

    visit root_path
    #click_on 'Sign out'
    click_on 'Sign out', visible: false
    expect(page).to have_content('Signed out successfully.')
  end
end