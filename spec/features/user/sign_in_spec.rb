require 'rails_helper'

feature 'User sign in', '
  In order be able to ask question
  As an user
  I want be able to sign in
' do

  given(:user) { create(:user) }

  scenario 'Registered user trying to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user trying to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'Test1@test.com'
    fill_in 'Password', with: '123456'

    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end
end