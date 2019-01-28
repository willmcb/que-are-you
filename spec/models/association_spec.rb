require 'rails_helper'

RSpec.describe Association, type: :model do
  before :each do
  @test_user1 = create(:user)
  @test_user2 = create(:user, email: 'testuser2@test.com')
end


  it "cannot add yourself as an associate" do
    expect(@test_user2.associations.length).to eq 0
    Association.create(user_id: @test_user2.id, associate_id: @test_user2.id)
    expect(@test_user2.associations.length).to eq 0
  end

  it "cannot add an associate twice" do
    Association.create(user_id: @test_user2.id, associate_id: @test_user1.id)
    expect(@test_user2.associations.length).to eq 1
    Association.create(user_id: @test_user2.id, associate_id: @test_user1.id)
    expect(@test_user2.associations.length).to eq 1
  end

end
