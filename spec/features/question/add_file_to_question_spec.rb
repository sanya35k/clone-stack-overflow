require 'support/features_helper'

feature 'Add file to question', '
  In order to give more information about my question
  As an authenticated user
  I want to be able to add files to the question
' do
  given!(:user) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }
  scenario 'Authenticated user tries add file to the question ', js: true do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      click_on 'Edit'
      click_on 'Add file'
      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
      click_on 'Save'

      expect(page).to have_link 'spec_helper.rb'
    end
  end
end