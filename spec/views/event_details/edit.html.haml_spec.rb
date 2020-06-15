require 'rails_helper'

RSpec.describe "event_details/edit", type: :view do
  before(:each) do
    @event_detail = assign(:event_detail, EventDetail.create!(
      game_id: 1,
      owner: "MyString",
      title: "MyString",
      latest: "MyString",
      boolean: "MyString",
      user_id: 1,
      event_id: 1
    ))
  end

  it "renders the edit event_detail form" do
    render

    assert_select "form[action=?][method=?]", event_detail_path(@event_detail), "post" do

      assert_select "input[name=?]", "event_detail[game_id]"

      assert_select "input[name=?]", "event_detail[owner]"

      assert_select "input[name=?]", "event_detail[title]"

      assert_select "input[name=?]", "event_detail[latest]"

      assert_select "input[name=?]", "event_detail[boolean]"

      assert_select "input[name=?]", "event_detail[user_id]"

      assert_select "input[name=?]", "event_detail[event_id]"
    end
  end
end
