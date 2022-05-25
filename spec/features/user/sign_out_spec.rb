require 'support/features_helper'

feature 'User sign out', '
  In order be able to end the session
  As an authenticated user
  I want be able to sign out
' do

  given(:user) { create(:user) }

  scenario 'Authenticated user sign out' do
    sign_in(user)

    visit root_path
    click_link "Sign out", visible: false
    expect(page).to have_content('Signed out successfully.')
  end
end
