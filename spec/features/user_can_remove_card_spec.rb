require 'rails_helper'


RSpec.describe "Buisness card" do
  include ActionView::Helpers

  before :each do
    @test_user1 = create(:user)
    @test_user2 = create(:user, email: 'testuser2@test.com')
    Association.create(user_id: @test_user2.id, associate_id: @test_user1.id)
    login_user2
  end

    it "can be removed" do
      visit "/"
      click_link 'Business cards'
      expect(page).to have_content 'Business cards'
      click_link 'remove'
      expect(page).to have_content 'Business card removed'
      expect(page).not_to have_content 'testuser2'
    end
  end
