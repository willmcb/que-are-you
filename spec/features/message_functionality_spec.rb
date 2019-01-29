require 'rails_helper'


RSpec.describe "Message functionality" do
  include ActionView::Helpers

  before :each do
    @test_user = create(:user)
    @test_user2 = create(:user, email: 'testuser2@test.com')
    Association.create(user_id: @test_user2.id, associate_id: @test_user.id)
    login_user2
  end

    it "view chat button is visible on business cards" do
      visit "/"
      click_link 'Business cards'
      expect(page).to have_content 'send message'
    end

    it "user can send a message to other user" do
      visit "/"
      click_link 'Business cards'
      click_link 'send message'
      fill_in 'message_content', with: 'This is a test message.'
      click_button 'Submit'
      logout
      login
      click_link 'My messages'
      expect(page).to have_content 'This is a test message.'
    end
  end
