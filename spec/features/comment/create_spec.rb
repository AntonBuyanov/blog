require 'rails_helper'

feature 'User can add comment', %q{
  In order to clarify information
  As an authenticated user
  I'd like to be able to create comment
} do

  given(:user) { create(:user) }
  given!(:post) { create(:post, author_id: user.id) }

  scenario 'Unauthenticated user tries to add comment' do
    visit post_path(post)
    click_on 'Add comment'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'Authenticated user add comment' do
    sign_in(user)
    visit post_path(post)

    within '.comments' do
      fill_in :comment_body, with: 'Comment 1'
      click_on 'Add comment'

      expect(page).to have_content 'Comment 1'
    end
  end
end
