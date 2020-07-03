require 'rails_helper'

RSpec.describe "information_provisions/index", type: :view do
  before(:each) do
    assign(:information_provisions, [
      InformationProvision.create!(),
      InformationProvision.create!()
    ])
  end

  it "renders a list of information_provisions" do
    render
  end
end
