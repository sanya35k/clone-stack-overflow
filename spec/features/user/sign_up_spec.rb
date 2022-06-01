require 'support/features_helper'

feature 'User sign up', '
In order to have access to all functionality of the system
As a non-authenticated user
I want be able to register
' do

  scenario 'New user trying to sign up with valid password data' do
    sign_up('test1@test.com', '123456', '123456')

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'New user trying to sign up with invalid password data' do
    sign_up('test1@test.com', '123456', '1234566')

    expect(page).to have_content "Password confirmation doesn't match Password"
    expect(current_path).to eq '/users'
  end

  scenario 'New user trying to sign up with taken email' do
    user = create :user
    sign_up(user.email, '123456', '123456')

    expect(page).to have_content 'Email has already been taken'
    expect(current_path).to eq '/users'
  end

  scenario 'New user trying to sign up with too short password' do
    sign_up('test1@test.com', '12345', '12345')

    expect(page).to have_content 'Password is too short (minimum is 6 characters)'
    expect(current_path).to eq '/users'
  end
end
