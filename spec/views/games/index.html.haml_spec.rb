require 'rails_helper'

RSpec.describe "games/index", type: :view do
  before(:each) do
    assign(:games, [
      Game.create!(
        title: "Title"
      ),
      Game.create!(
        title: "Title"
      )
    ])
  end

  it "renders a list of games" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
  end
end
