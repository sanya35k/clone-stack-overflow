require 'support/features_helper'

feature 'Show questions', '
  In order to find a question that interests me
  As an non-authenticated user
  I should be able see all questions
' do

  given(:user) { create(:user) }

  scenario 'Non-authenticated user sees all questions' do
    Question.create!(title: 'MyQuestion', body: 'MyBody', user_id: user.id)
    visit questions_path
    expect(page).to have_content('MyQuestion')
    expect(page).to have_content('MyBody')
  end
end
