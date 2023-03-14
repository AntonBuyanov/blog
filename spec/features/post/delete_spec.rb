require 'rails_helper'

feature 'User can delete post', %q{
  In order to create new post
  As an author post
  I'd like to be able to delete post
} do

  given(:user) { create(:user) }
  given(:user_not_author) { create(:user) }
  given!(:post) { create(:post, author_id: user.id) }

  scenario 'Unauthenticated user tries to delete post' do
    visit post_path(post)
    click_on 'Delete post'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'Authenticated user not author tries to edit post' do
    sign_in(user_not_author)
    visit post_path(post)

    click_on 'Delete post'

    expect(page).to have_content 'You is not author post'
  end

  scenario 'Authenticated user delete his post' do
    sign_in(user)
    visit post_path(post)
    click_on 'Delete post'

    expect(page).to have_content 'Your post successfully delete'
  end
end
