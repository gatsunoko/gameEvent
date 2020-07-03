require 'rails_helper'

RSpec.describe "information_provisions/new", type: :view do
  before(:each) do
    assign(:information_provision, InformationProvision.new())
  end

  it "renders new information_provision form" do
    render

    assert_select "form[action=?][method=?]", information_provisions_path, "post" do
    end
  end
end
