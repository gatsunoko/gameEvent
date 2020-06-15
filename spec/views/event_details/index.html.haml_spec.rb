require 'rails_helper'

RSpec.describe "event_details/index", type: :view do
  before(:each) do
    assign(:event_details, [
      EventDetail.create!(
        game_id: 2,
        owner: "Owner",
        title: "Title",
        latest: "Latest",
        boolean: "Boolean",
        user_id: 3,
        event_id: 4
      ),
      EventDetail.create!(
        game_id: 2,
        owner: "Owner",
        title: "Title",
        latest: "Latest",
        boolean: "Boolean",
        user_id: 3,
        event_id: 4
      )
    ])
  end

  it "renders a list of event_details" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Owner".to_s, count: 2
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Latest".to_s, count: 2
    assert_select "tr>td", text: "Boolean".to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
  end
end
