require 'rails_helper'

feature 'User can create post', %q{
  In order to share information
  As an authenticated user
  I'd like to be able to create post
} do

  given(:user) { create(:user) }

  scenario 'Unauthenticated user tries to create post' do
    visit posts_path
    click_on 'New post'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit posts_path
      click_on 'New post'
    end

    scenario 'create post' do
      fill_in 'Your post', with: 'Post 1'
      fill_in 'Body', with: 'text text text'
      click_on 'Create post'

      expect(page).to have_content 'Your post successfully created'
      expect(page).to have_content 'Post 1'
      expect(page).to have_content 'text text text'
    end

    scenario 'create post with errors' do
      click_on 'Create post'

      expect(page).to have_content "Title can't be blank"
    end

    scenario 'create post with attached images' do
      fill_in 'Your post', with: 'Post 1'
      fill_in 'Body', with: 'text text text'

      attach_file 'Image', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Create post'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end
end
