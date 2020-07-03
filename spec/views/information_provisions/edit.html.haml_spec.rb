require 'rails_helper'

RSpec.describe "information_provisions/edit", type: :view do
  before(:each) do
    @information_provision = assign(:information_provision, InformationProvision.create!())
  end

  it "renders the edit information_provision form" do
    render

    assert_select "form[action=?][method=?]", information_provision_path(@information_provision), "post" do
    end
  end
end
