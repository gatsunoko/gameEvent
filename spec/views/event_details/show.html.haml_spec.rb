require 'rails_helper'

RSpec.describe "event_details/show", type: :view do
  before(:each) do
    @event_detail = assign(:event_detail, EventDetail.create!(
      game_id: 2,
      owner: "Owner",
      title: "Title",
      latest: "Latest",
      boolean: "Boolean",
      user_id: 3,
      event_id: 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Owner/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Latest/)
    expect(rendered).to match(/Boolean/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
