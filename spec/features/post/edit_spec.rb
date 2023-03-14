require 'rails_helper'

feature 'User can edit post', %q{
  In order to correct mistakes
  As an author post
  I'd like to be able to edit my post
} do

  given(:user) { create(:user) }
  given(:user_not_author) { create(:user) }
  given!(:post) { create(:post, author_id: user.id) }

  scenario 'Unauthenticated user tries to edit post' do
    visit post_path(post)
    click_on 'Edit'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'Authenticated user not author tries to edit post' do
    sign_in(user_not_author)
    visit post_path(post)

    click_on 'Edit'
    click_on 'Save'

    expect(page).to have_content 'You is not author post'
  end

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit post_path(post)
      click_on 'Edit'
    end

    scenario 'edit his post with attached image' do
      fill_in 'Your post', with: 'Post 12'
      fill_in 'Body', with: 'text text'
      attach_file 'Images', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Save'

      expect(page).to have_content 'Post 1'
      expect(page).to have_content 'text text'
      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

    scenario 'remove image his post' do
      attach_file 'Images', "#{Rails.root}/spec/rails_helper.rb"
      click_on 'Save'
      click_on 'Delete image'

      expect(page).to_not have_link 'rails_helper.rb'
    end
  end
end
