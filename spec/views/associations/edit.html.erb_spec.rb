require 'rails_helper'

RSpec.describe "associations/edit", type: :view do
  before(:each) do
    @association = assign(:association, Association.create!(
      :user => nil,
      :user => nil
    ))
  end

  it "renders the edit association form" do
    render

    assert_select "form[action=?][method=?]", association_path(@association), "post" do

      assert_select "input[name=?]", "association[user_id]"

      assert_select "input[name=?]", "association[user_id]"
    end
  end
end
