require 'rails_helper'

RSpec.describe "associations/new", type: :view do
  before(:each) do
    assign(:association, Association.new(
      :user => nil,
      :user => nil
    ))
  end

  it "renders new association form" do
    render

    assert_select "form[action=?][method=?]", associations_path, "post" do

      assert_select "input[name=?]", "association[user_id]"

      assert_select "input[name=?]", "association[user_id]"
    end
  end
end
