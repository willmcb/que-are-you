require 'rails_helper'

RSpec.describe User, type: :model do

  before(:all) do
    @user1 = create(:user)
  end

  it "It is valid with valid attributes" do
    expect(@user1).to be_valid
  end

  it "has a unique email" do
    user2 = build(:user)
    expect(user2).to_not be_valid
  end

  it "is not valid without a password" do
    user2 = build(:user, password: nil, password_confirmation: nil)
    expect(user2).to_not be_valid
  end

  it "is not valid without a firstname" do
    user2 = build(:user, firstname: nil)
    expect(user2).to_not be_valid
  end

  it "is not valid without a lastname" do
    user2 = build(:user, lastname: nil)
    expect(user2).to_not be_valid
  end

  it "is not valid without an email" do
    user2 = build(:user, email: nil)
    expect(user2).to_not be_valid
  end
end
